#!/system/bin/sh
until [ "$(getprop sys.boot_completed)" = "1" ]; do sleep 2; done

MODDIR=${0%/*}
DST_DIR=/sdcard/Android/data/ru.lesnik.x50navigation/files
STATUS=$DST_DIR/x50_staging_status.json
LOG=$MODDIR/staging.log
NAVIGATOR=ru.yandex.yandexnavi
APPMETRICA_SETTING=x50_navigation_perf_block_appmetrica
APPMETRICA_SERVICE=$NAVIGATOR/io.appmetrica.analytics.internal.AppMetricaService
APPMETRICA_MAIN_SERVICE=$NAVIGATOR/io.appmetrica.analytics.internal.AppMetricaMainProcessService

# Physical GPS/NMEA and satellite status require a runtime grant even for a
# privileged system APK. The service start below retries early registrations.
# This does not select or grant the mock-location application.
pm grant ru.lesnik.x50navigation android.permission.ACCESS_FINE_LOCATION \
  >>"$LOG" 2>&1 || true

# Navigation reads only the ECarX values needed for route progress. This is
# not a LocationManager or mock-location permission.
pm grant ru.lesnik.x50navigation android.car.permission.CAR_VENDOR_EXTENSION \
  >/dev/null 2>&1 || true

# Never persist the dangerous diagnostic correction bypass across a reboot.
settings put global x50_navigation_gps_correction_disabled 0 >/dev/null 2>&1 \
  || true

# MapKit is the only route source. Remove obsolete staged fallbacks left by
# older module versions so neither diagnostics nor external tools can mistake
# them for current data.
rm -f "$DST_DIR/yandex_guidance_navigation_state" \
  "$DST_DIR/yandex_guidance_navigation_state.state" \
  "$DST_DIR/yandex_guidance_navigation_state.mtime" \
  "$DST_DIR/yandex_known_route_history" \
  "$DST_DIR/yandex_known_route_history.state" \
  "$DST_DIR/yandex_known_route_history.mtime" \
  "$DST_DIR/yandex_exact_route.json" \
  "$DST_DIR/yandex_exact_route.json.state" \
  "$DST_DIR/yandex_exact_route.json.mtime"

stage_file() {
  src="$1"
  name="$2"
  dst="$DST_DIR/$name"
  STAGE_OK=0
  STAGE_MTIME=0
  STAGE_SIZE=0
  [ -s "$src" ] || return
  STAGE_MTIME="$(toybox stat -c %Y "$src" 2>/dev/null || stat -c %Y "$src" 2>/dev/null)"
  STAGE_SIZE="$(toybox stat -c %s "$src" 2>/dev/null || stat -c %s "$src" 2>/dev/null)"
  state="$STAGE_MTIME $STAGE_SIZE"
  previous="$(cat "$dst.state" 2>/dev/null)"
  if [ -s "$dst" ] && [ "$state" = "$previous" ]; then
    STAGE_OK=1
    return
  fi
  mkdir -p "$DST_DIR" >/dev/null 2>&1
  if (toybox cp "$src" "$dst.tmp" 2>/dev/null || cp "$src" "$dst.tmp" 2>/dev/null) \
      && [ -s "$dst.tmp" ]; then
    chmod 0644 "$dst.tmp" >/dev/null 2>&1
    mv "$dst.tmp" "$dst"
    printf '%s\n' "$state" > "$dst.state"
    STAGE_OK=1
    printf '%s staged %s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$name" "$state" >> "$LOG"
  fi
}

# AppMetrica is a distinct process owned by two manifest services.  The
# Navigator process itself cannot reliably intercept its framework start path;
# Magisk can change exactly those two component states instead.  Do not touch
# Passport, Firebase, push or any MapKit component here.
last_appmetrica_state=""
apply_appmetrica_state() {
  desired="$(settings get global "$APPMETRICA_SETTING" 2>/dev/null)"
  [ "$desired" = "1" ] || desired=0
  [ "$desired" = "$last_appmetrica_state" ] && return
  if [ "$desired" = "1" ]; then
    pm disable "$APPMETRICA_SERVICE" >/dev/null 2>&1
    pm disable "$APPMETRICA_MAIN_SERVICE" >/dev/null 2>&1
    printf '%s AppMetrica components disabled; restart Navigator to stop its process\n' \
      "$(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG"
  else
    pm enable "$APPMETRICA_SERVICE" >/dev/null 2>&1
    pm enable "$APPMETRICA_MAIN_SERVICE" >/dev/null 2>&1
    printf '%s AppMetrica components enabled; restart Navigator to restore defaults\n' \
      "$(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG"
  fi
  last_appmetrica_state="$desired"
}

(
  while true; do
    apply_appmetrica_state
    stage_file /data/data/ru.yandex.yandexnavi/files/x50_navigation_route.json \
      yandex_navigation_route.json
    mapkit_ok=$STAGE_OK; mapkit_mtime=$STAGE_MTIME; mapkit_size=$STAGE_SIZE
    heartbeat_ms="$(date +%s 2>/dev/null)000"
    mkdir -p "$DST_DIR" >/dev/null 2>&1
    printf '{"heartbeat_ms":%s,"source":"mapkit","mapkit":{"ok":%s,"source_mtime_s":%s,"size":%s}}\n' \
      "$heartbeat_ms" "$mapkit_ok" "$mapkit_mtime" "$mapkit_size" > "$STATUS.tmp" \
      && chmod 0644 "$STATUS.tmp" && mv "$STATUS.tmp" "$STATUS"
    sleep 1
  done
) &

am start-foreground-service -a ru.lesnik.x50navigation.START \
  -n ru.lesnik.x50navigation/.NavigationService >/dev/null 2>&1 \
  || am startservice -a ru.lesnik.x50navigation.START \
  -n ru.lesnik.x50navigation/.NavigationService >/dev/null 2>&1

# Remote ADB is optional and fail-closed; this worker does not change adbd
# without a complete consented session and installed pinned transport.
chmod 0755 "$MODDIR/remote-adb-worker.sh" >/dev/null 2>&1 || true
settings put global x50_navigation_remote_adb_worker_available 1 >/dev/null 2>&1 || true
"$MODDIR/remote-adb-worker.sh" "$MODDIR" >/dev/null 2>&1 &

# The key manager is separate from the temporary VDS worker.  It only exposes
# public key material to this app's own external storage and preserves keys it
# did not create.
chmod 0755 "$MODDIR/adb-key-manager.sh" >/dev/null 2>&1 || true
"$MODDIR/adb-key-manager.sh" >/dev/null 2>&1 &
