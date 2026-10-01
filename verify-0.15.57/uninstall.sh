#!/system/bin/sh

# A Magisk system-app removal does not always invoke Android's normal APK
# uninstall lifecycle. Clear the exact package sandbox so a permanent offline
# licence, pending activation request and installation ID cannot survive a
# complete Navigation-module removal.
am force-stop ru.lesnik.x50navigation >/dev/null 2>&1 || true
pm clear ru.lesnik.x50navigation >/dev/null 2>&1 || true
for package in ru.lesnik.x50fakenavon ru.lesnik.x50fakenavoff ru.lesnik.x50fakenavtoggle; do
  am force-stop "$package" >/dev/null 2>&1 || true
  pm clear "$package" >/dev/null 2>&1 || true
done
rm -rf /data/user/0/ru.lesnik.x50navigation \
  /data/user_de/0/ru.lesnik.x50navigation \
  /data/misc_ce/0/ru.lesnik.x50navigation >/dev/null 2>&1 || true
rm -rf /data/adb/x50-navigation-remote-adb >/dev/null 2>&1 || true
rm -rf /data/adb/x50-navigation-adb-key-manager >/dev/null 2>&1 || true

# Remove only legacy activation mirrors. Ordinary Navigation settings are left
# intact unless their owning app sandbox was removed above.
for key in \
  x50_navigation_enabled \
  x50_navigation_heartbeat_ms \
  x50_navigation_license_json \
  x50_navigation_license_valid \
  x50_navigation_license_status \
  x50_navigation_license_checked_at_ms \
  x50_navigation_installation_id \
  x50_navigation_local_activation_code \
  x50_navigation_local_activation_expires_ms \
  x50_navigation_vin_candidate_hash \
  x50_navigation_vin_stable_reads \
  x50_navigation_test_vin_device \
  x50_navigation_test_vin_property \
  x50_navigation_remote_adb_enabled \
  x50_navigation_remote_adb_worker_available \
  x50_navigation_remote_adb_session_id \
  x50_navigation_remote_adb_expires_at_ms \
  x50_navigation_remote_adb_remote_port \
  x50_navigation_remote_adb_public_key \
  x50_navigation_remote_adb_ssh_host \
  x50_navigation_remote_adb_ssh_user \
  x50_navigation_remote_adb_runtime_state \
  x50_navigation_adb_key_manager_command \
  x50_navigation_adb_key_manager_requested_key \
  x50_navigation_adb_key_manager_state \
  x50_navigation_adb_key_manager_detail; do
  settings delete global "$key" >/dev/null 2>&1 || true
done
