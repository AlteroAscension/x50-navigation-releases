#!/system/bin/sh
# Fail-closed remote ADB worker owned by the X50 Navigation Magisk module.
# It never evaluates server-supplied shell text and never touches ADB until a
# complete, explicit session is present. The Navigation app owns the outbound
# TLS WebSocket tunnel; this worker owns only the temporary key and firewall.
#
# Never start/restart adbd and never change adb/USB properties here.  Some
# legacy kernels panic in USB FunctionFS when TCP adbd is reconfigured.

MODDIR="$1"
STATE_DIR=/data/adb/x50-navigation-remote-adb
KEY_FILE="$STATE_DIR/adb-public-key"
STAGED_KEY_FILE=/sdcard/adbkey.pub
ADDED_KEY_FILE="$STATE_DIR/added-adb-key"
OWNED_FILE="$STATE_DIR/owned"
IDLE_CLEANUP_FILE="$STATE_DIR/idle-cleanup-complete"
PID_FILE="$STATE_DIR/tunnel.pid"
FIREWALL_PORT_FILE="$STATE_DIR/firewall-port"
CHAIN=X50NAV_REMOTE_ADB

get() { settings get global "$1" 2>/dev/null; }
state() { settings put global x50_navigation_remote_adb_worker_state "$1" >/dev/null 2>&1 || true; }
digits() { case "$1" in ''|*[!0-9]*) return 1 ;; *) return 0 ;; esac; }
valid_local_port() { digits "$1" && [ "$1" -ge 1024 ] && [ "$1" -le 65535 ]; }
valid_public_key() {
  key="$1"; payload="${key%% *}"
  [ "${#payload}" -eq 700 ] || return 1
  case "$payload" in QAAA[A-Za-z0-9+/=]*) ;; *) return 1 ;; esac
  case "$payload" in *[!A-Za-z0-9+/=]*) return 1 ;; esac
  return 0
}

# Vendor adbd on SX11A3 attempts to decode every line, including blank lines.
# Keep only canonical Android RSA public-key records, but overwrite the same
# inode so its owner, group and SELinux label remain controlled by Android.
sanitize_keys() {
  adb_keys=/data/misc/adb/adb_keys
  [ -f "$adb_keys" ] || return 1
  tr -d '\r' < "$adb_keys" | sed -n '/^QAAA/p' > "$adb_keys.x50-navigation.tmp" || return 1
  cat "$adb_keys.x50-navigation.tmp" > "$adb_keys" || return 1
  rm -f "$adb_keys.x50-navigation.tmp"
  chmod 0640 "$adb_keys" >/dev/null 2>&1 || true
  restorecon "$adb_keys" >/dev/null 2>&1 || true
}

remove_firewall() {
  command -v iptables >/dev/null 2>&1 || return
  local_port="$(cat "$FIREWALL_PORT_FILE" 2>/dev/null | tr -cd '0-9')"
  # Older releases used 5555 and did not store the port. Remove their chain
  # too, without touching adbd or any system property.
  valid_local_port "$local_port" || local_port=5555
  while iptables -D INPUT -p tcp --dport "$local_port" -j "$CHAIN" >/dev/null 2>&1; do :; done
  iptables -F "$CHAIN" >/dev/null 2>&1 || true
  iptables -X "$CHAIN" >/dev/null 2>&1 || true
}

remove_key() {
  adb_keys=/data/misc/adb/adb_keys
  [ -s "$KEY_FILE" ] && [ -f "$adb_keys" ] || return
  grep -F -x -v -f "$KEY_FILE" "$adb_keys" > "$adb_keys.x50-navigation.tmp" 2>/dev/null
  rc=$?
  [ "$rc" -eq 0 ] || [ "$rc" -eq 1 ] || return
  cat "$adb_keys.x50-navigation.tmp" > "$adb_keys" || return
  rm -f "$adb_keys.x50-navigation.tmp"
  sanitize_keys || true
}

cleanup() {
  if [ -f "$PID_FILE" ]; then
    pid="$(cat "$PID_FILE" 2>/dev/null | tr -cd '0-9')"
    [ -n "$pid" ] && kill "$pid" >/dev/null 2>&1 || true
  fi
  remove_firewall
  if [ "$(get x50_navigation_remote_adb_revoke_key)" = 1 ]; then
    [ -f "$ADDED_KEY_FILE" ] && remove_key
    settings delete global x50_navigation_remote_adb_revoke_key >/dev/null 2>&1 || true
    rm -f "$KEY_FILE" "$ADDED_KEY_FILE"
  fi
  # A session is intentionally unable to alter adbd.  In particular, do not
  # attempt legacy restoration here: stale pre-0.15.30 state must be harmless.
  rm -f "$STAGED_KEY_FILE" "$PID_FILE" "$OWNED_FILE" "$FIREWALL_PORT_FILE"
  settings delete global x50_navigation_remote_adb_local_port >/dev/null 2>&1 || true
}

start() {
  enabled="$(get x50_navigation_remote_adb_enabled)"
  session="$(get x50_navigation_remote_adb_session_id)"
  expires="$(get x50_navigation_remote_adb_expires_at_ms)"
  port="$(get x50_navigation_remote_adb_remote_port)"
  public_key="$(get x50_navigation_remote_adb_public_key)"
  now="$(date +%s 2>/dev/null | tr -cd '0-9')000"

  if [ "$enabled" != 1 ] || ! digits "$expires" || ! digits "$port" \
      || [ "$expires" -le "$now" ] || [ "$port" -lt 23000 ] || [ "$port" -gt 23100 ] \
      || [ -z "$session" ] || ! valid_public_key "$public_key"; then
    # An expired/incomplete session must clean up once, never touch adbd.
    if [ ! -f "$IDLE_CLEANUP_FILE" ]; then
      cleanup
      mkdir -p "$STATE_DIR" >/dev/null 2>&1 || true
      : > "$IDLE_CLEANUP_FILE" 2>/dev/null || true
    fi
    state off; return
  fi
  rm -f "$IDLE_CLEANUP_FILE"
  if [ -f "$OWNED_FILE" ] && [ "$(cat "$OWNED_FILE" 2>/dev/null)" = "$session" ]; then
    state prepared
    return
  fi

  cleanup
  mkdir -p "$STATE_DIR" || { state state_error; return; }
  # Read only. A local adbd endpoint may use any safe TCP port; the external
  # server has its own unrelated session port and never needs this value.
  local_port="$(getprop service.adb.tcp.port 2>/dev/null | tr -cd '0-9')"
  valid_local_port "$local_port" || { state local_adbd_error; return; }
  adb_keys=/data/misc/adb/adb_keys
  # Older Android builds do not create adb_keys until the first manual USB
  # authorisation.  The system file is never replaced: adbd depends on its
  # Android-created inode, ownership and SELinux label.
  if [ ! -e "$adb_keys" ]; then
    mkdir -p /data/misc/adb >/dev/null 2>&1 || { state adb_keys_missing; return; }
    : > "$adb_keys" || { state adb_keys_missing; return; }
    chmod 0640 "$adb_keys" >/dev/null 2>&1 || true
  fi
  [ -f "$adb_keys" ] || { state adb_keys_missing; return; }
  sanitize_keys || { state adb_key_error; return; }
  command -v iptables >/dev/null 2>&1 || { state firewall_missing; return; }
  printf '%s\n' "$public_key" > "$KEY_FILE" || { state state_error; return; }
  chmod 0600 "$KEY_FILE" >/dev/null 2>&1 || true
  if ! grep -F -x -q -f "$KEY_FILE" "$adb_keys" 2>/dev/null; then
    # A valid Android record is one non-empty LF-terminated line. Do not add
    # blank separators: this vendor's old adbd reports them as invalid keys.
    printf '%s\n' "$public_key" > "$STAGED_KEY_FILE" || { cleanup; state adb_key_error; return; }
    cat "$STAGED_KEY_FILE" >> "$adb_keys" \
      || { rm -f "$STAGED_KEY_FILE"; cleanup; state adb_key_error; return; }
    rm -f "$STAGED_KEY_FILE"
    : > "$ADDED_KEY_FILE"
  fi

  iptables -N "$CHAIN" >/dev/null 2>&1 || true
  iptables -F "$CHAIN" >/dev/null 2>&1 || { cleanup; state firewall_error; return; }
  iptables -A "$CHAIN" -i lo -p tcp --dport "$local_port" -j ACCEPT >/dev/null 2>&1 || { cleanup; state firewall_error; return; }
  iptables -A "$CHAIN" -p tcp --dport "$local_port" -j DROP >/dev/null 2>&1 || { cleanup; state firewall_error; return; }
  iptables -I INPUT -p tcp --dport "$local_port" -j "$CHAIN" >/dev/null 2>&1 || { cleanup; state firewall_error; return; }

  printf '%s\n' "$local_port" > "$FIREWALL_PORT_FILE"
  settings put global x50_navigation_remote_adb_local_port "$local_port" >/dev/null 2>&1 || { cleanup; state state_error; return; }
  printf '%s\n' "$session" > "$OWNED_FILE"
  state prepared
}

# Every boot revokes the capability. Existing adbd configuration is always
# untouched, including stale state created by an older module release.
cleanup
settings put global x50_navigation_remote_adb_enabled 0 >/dev/null 2>&1 || true
mkdir -p "$STATE_DIR" >/dev/null 2>&1 || true
: > "$IDLE_CLEANUP_FILE" 2>/dev/null || true
state off
while true; do
  start
  sleep 2
done
