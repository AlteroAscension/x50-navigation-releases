#!/system/bin/sh
# Rooted ADB public-key manager for X50 Navigation.  It deliberately owns a
# single tracked key only; any pre-existing system/Lunaris keys are preserved.
# The app requests work through Settings.Global and reads a public snapshot from
# its own external-files directory.  No private ADB key is stored on the GU.

STATE_DIR=/data/adb/x50-navigation-adb-key-manager
MANAGED_KEY="$STATE_DIR/managed-adb-public-key"
ADB_KEYS=/data/misc/adb/adb_keys
STAGED_KEY=/sdcard/adbkey.pub
APP_DIR=/sdcard/Android/data/ru.lesnik.x50navigation/files
SNAPSHOT="$APP_DIR/x50_adb_keys.txt"

# Android's settings CLI prints the literal string "null" for an absent key.
# Treat it exactly as unset; otherwise the idle loop would report a phantom
# unknown command forever.
get() { value="$(settings get global "$1" 2>/dev/null)"; [ "$value" = "null" ] && value=""; printf '%s' "$value"; }
put() { settings put global "$1" "$2" >/dev/null 2>&1 || true; }
idle() { put x50_navigation_adb_key_manager_state idle; put x50_navigation_adb_key_manager_detail ""; }
fail() { put x50_navigation_adb_key_manager_state error; put x50_navigation_adb_key_manager_detail "$1"; }

snapshot() {
  mkdir -p "$APP_DIR" >/dev/null 2>&1 || { fail snapshot_dir; return 1; }
  if [ -f "$ADB_KEYS" ]; then
    sed -n '/^QAAA/p' "$ADB_KEYS" > "$SNAPSHOT.tmp" 2>/dev/null || { fail snapshot_read; return 1; }
  else
    : > "$SNAPSHOT.tmp" || { fail snapshot_write; return 1; }
  fi
  chmod 0644 "$SNAPSHOT.tmp" >/dev/null 2>&1 || true
  mv "$SNAPSHOT.tmp" "$SNAPSHOT" || { fail snapshot_write; return 1; }
  put x50_navigation_adb_key_manager_state idle
  put x50_navigation_adb_key_manager_detail "snapshot_ready"
  return 0
}

valid_key() {
  payload="${1%% *}"
  [ "${#payload}" -eq 700 ] || return 1
  case "$payload" in QAAA*) ;; *) return 1 ;; esac
  case "$payload" in *[!A-Za-z0-9+/=]*) return 1 ;; esac
  return 0
}

# Preserve the Android-created adb_keys inode and its security metadata.  This
# adbd validates every record, including blank lines, so only canonical public
# Android RSA keys are retained.
sanitize_keys() {
  [ -f "$ADB_KEYS" ] || return 1
  tr -d '\r' < "$ADB_KEYS" | sed -n '/^QAAA/p' > "$ADB_KEYS.x50-key-manager.tmp" || return 1
  cat "$ADB_KEYS.x50-key-manager.tmp" > "$ADB_KEYS" || return 1
  rm -f "$ADB_KEYS.x50-key-manager.tmp"
  chmod 0640 "$ADB_KEYS" >/dev/null 2>&1 || true
  restorecon "$ADB_KEYS" >/dev/null 2>&1 || true
}

remove_managed() {
  [ -s "$MANAGED_KEY" ] && [ -f "$ADB_KEYS" ] || return 0
  grep -F -x -v -f "$MANAGED_KEY" "$ADB_KEYS" > "$ADB_KEYS.x50-key-manager.tmp" 2>/dev/null
  rc=$?
  [ "$rc" -eq 0 ] || [ "$rc" -eq 1 ] || return 1
  cat "$ADB_KEYS.x50-key-manager.tmp" > "$ADB_KEYS" || return 1
  rm -f "$ADB_KEYS.x50-key-manager.tmp"
  sanitize_keys || return 1
  return 0
}

apply() {
  # Do not race the temporary VDS key worker on the same system file.
  [ "$(get x50_navigation_remote_adb_enabled)" != 1 ] || { fail remote_tunnel_active; return 1; }
  key="$(get x50_navigation_adb_key_manager_requested_key)"
  valid_key "$key" || { fail invalid_public_key; return 1; }
  mkdir -p "$STATE_DIR" /data/misc/adb >/dev/null 2>&1 || { fail adb_dir; return 1; }
  [ -e "$ADB_KEYS" ] || : > "$ADB_KEYS" || { fail adb_keys; return 1; }
  [ -f "$ADB_KEYS" ] || { fail adb_keys; return 1; }
  sanitize_keys || { fail adb_keys; return 1; }
  put x50_navigation_adb_key_manager_state working
  remove_managed || { fail remove_old; return 1; }
  printf '%s\n' "$key" > "$STAGED_KEY" || { fail stage_key; return 1; }
  # One canonical, LF-terminated key record; no blank separator records.
  cat "$STAGED_KEY" >> "$ADB_KEYS" \
    || { rm -f "$STAGED_KEY"; fail import_key; return 1; }
  rm -f "$STAGED_KEY"
  printf '%s\n' "$key" > "$MANAGED_KEY" || { fail track_key; return 1; }
  chmod 0600 "$MANAGED_KEY" >/dev/null 2>&1 || true
  settings delete global x50_navigation_adb_key_manager_requested_key >/dev/null 2>&1 || true
  snapshot || return 1
  put x50_navigation_adb_key_manager_state applied
  put x50_navigation_adb_key_manager_detail "managed_key_replaced"
  return 0
}

mkdir -p "$STATE_DIR" >/dev/null 2>&1 || true
idle
while true; do
  command="$(get x50_navigation_adb_key_manager_command)"
  case "$command" in
    snapshot) snapshot ;;
    apply) apply ;;
    '') ;;
    *) fail unknown_command ;;
  esac
  [ -z "$command" ] || settings delete global x50_navigation_adb_key_manager_command >/dev/null 2>&1 || true
  sleep 1
done
