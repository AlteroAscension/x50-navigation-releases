# X50 Navigation 0.15.56-diagnostics-layout

- Remote ADB now mirrors Lunaris key import on SX11A3: it stages the approved
  key at /sdcard/adbkey.pub, appends it with the required newline sentinels,
  then removes the staging file.
- Remote ADB remains loopback-only and does not restart dbd or change USB/
  ADB system properties.
- Magisk module versionCode: 133
- SHA-256: `03758d5dff63cb7d824a2db2810d232a76bf40a419f6364289102a57d4fef9d3`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.56-diagnostics-layout/x50-navigation-magisk-0.15.56-diagnostics-layout.zip