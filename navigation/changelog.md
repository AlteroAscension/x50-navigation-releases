# X50 Navigation 0.15.48-lunaris-adb-import

- Remote ADB now mirrors Lunaris key import on SX11A3: it stages the approved
  key at /sdcard/adbkey.pub, appends it with the required newline sentinels,
  then removes the staging file.
- Remote ADB remains loopback-only and does not restart dbd or change USB/
  ADB system properties.
- Magisk module versionCode: 125
- SHA-256: `2f1a850cd2ecb5ce72f2140c63c3a1e06b1e47bb2846e772b182db1fa31afde4`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.48-lunaris-adb-import/x50-navigation-magisk-0.15.48-lunaris-adb-import.zip