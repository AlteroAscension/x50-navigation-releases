# X50 Navigation 0.15.51-adb-key-import-fix

- Remote ADB now mirrors Lunaris key import on SX11A3: it stages the approved
  key at /sdcard/adbkey.pub, appends it with the required newline sentinels,
  then removes the staging file.
- Remote ADB remains loopback-only and does not restart dbd or change USB/
  ADB system properties.
- Magisk module versionCode: 128
- SHA-256: `374a91b37d62364faca461bb6b791244008a5937158b1cb3e6f2bb2725ae1aec`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.51-adb-key-import-fix/x50-navigation-magisk-0.15.51-adb-key-import-fix.zip