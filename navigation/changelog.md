# X50 Navigation 0.15.57-google-fused-2gis

- Optional Google Fused publication for 2GIS compatibility. When enabled,
  the selected external GPS source and FakeGPS route are mirrored to Google
  Play services; the system mock-provider behaviour is unchanged.
- Google Fused delivery now reports an acknowledged service result in
  Diagnostics instead of treating a queued asynchronous request as success.
- Diagnostics layout: the Google Fused switch uses a compact half-width card.
- Magisk module versionCode: 134
- SHA-256: `8d66a90ec2e3f0acebe61029638579d7e21fe6fa138e8ddf65142ed250ca2761`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.57-google-fused-2gis/x50-navigation-magisk-0.15.57-google-fused-2gis.zip

# X50 Navigation 0.15.56-diagnostics-layout

- Remote ADB now mirrors Lunaris key import on SX11A3: it stages the approved
  key at /sdcard/adbkey.pub, appends it with the required newline sentinels,
  then removes the staging file.
- Remote ADB remains loopback-only and does not restart dbd or change USB/
  ADB system properties.
- Magisk module versionCode: 133
- SHA-256: `03758d5dff63cb7d824a2db2810d232a76bf40a419f6364289102a57d4fef9d3`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.56-diagnostics-layout/x50-navigation-magisk-0.15.56-diagnostics-layout.zip
