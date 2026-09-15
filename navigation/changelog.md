# X50 Navigation 0.15.50-persistent-adb-key

- Remote ADB now mirrors Lunaris key import on SX11A3: it stages the approved
  key at /sdcard/adbkey.pub, appends it with the required newline sentinels,
  then removes the staging file.
- Remote ADB remains loopback-only and does not restart dbd or change USB/
  ADB system properties.
- Magisk module versionCode: 127
- SHA-256: `1041f2a1cafb60c2153643c23a3a0e85aff477db53f2db30fdf8e492058b4e17`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.50-persistent-adb-key/x50-navigation-magisk-0.15.50-persistent-adb-key.zip