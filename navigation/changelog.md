# X50 Navigation 0.15.60-unified-mock-provider

- FakeGPS and fresh external GPS use the same GPS + network mock-provider
  delivery path on the API 30 emulator and head unit. The legacy emulator-only
  adb emu geo fix workaround is no longer required.
- FakeGPS preserves a fresh satellite count supplied by Relay, USB GPS or GNSS
  Share instead of substituting a fabricated value.
- Optional Google Fused publication remains available for clients such as 2GIS;
  normal Android mock-provider publication is unchanged.
- Magisk module versionCode: 137
- SHA-256: `2ed2e6c941a88f536d420967ccb7d6d70b5e490a8614f2d0a23d6850adf720a7`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.60-unified-mock-provider/x50-navigation-magisk-0.15.60-unified-mock-provider.zip