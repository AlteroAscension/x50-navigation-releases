# X50 Navigation 0.15.65-provider-fix

- Protected builds retain the declared 2GIS route bridge provider, preventing
  a startup crash after the module is installed.
- Relay satellite observations remain stable through optional packets that omit
  the field; an explicitly reported zero is still passed through as zero.
- The protected build keeps the reflected Google Fused mock-location API for
  2GIS compatibility on devices where Google Play services are available.
- Magisk module versionCode: 142
- SHA-256: `fda7bdfd6f4de9449b0fa661e5480b82de2964dd29630fbeef15e2e0dbec45a0`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.65-provider-fix/x50-navigation-magisk-0.15.65-provider-fix.zip