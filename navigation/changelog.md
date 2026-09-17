# X50 Navigation 0.15.69-2gis-selected-route

- 2GIS route capture now selects the primary route shown in 2GIS instead of
  blindly taking the last cached alternative. Route identity changes with the
  selected geometry, so Relay and Home Assistant receive route reselection.
- In FakeGPS, the current satellite count is additionally published through
  the compatible GNSS Share broadcast for SCORO. Explicit zero remains zero;
  no SystemUI hook is used.
- The protected build keeps the reflected Google Fused mock-location API for
  2GIS compatibility on devices where Google Play services are available.
- Magisk module versionCode: 146
- SHA-256: `02136094231c09459e7aad935948e1cb0b7ff08d962a2ec425fc16ff1bc05d25`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.69-2gis-selected-route/x50-navigation-magisk-0.15.69-2gis-selected-route.zip