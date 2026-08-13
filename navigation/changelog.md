# X50 Navigation 0.12.28-background-sdk-control

- Added an opt-in, root-backed AppMetrica controller: it disables only the two
  Navigator AppMetrica services. Restart Navigator after changing the switch.
- Confirmed on AVD: Navigator and Passport remain active while the separate
  `:AppMetrica` process is absent; switching back restores the default state.
- MapKit/FakeGPS, Firebase, Crashlytics, FCM and Passport are not changed by
  this release.
- Protected binary Magisk module; activation required.
- Magisk module versionCode: 54.
- SHA-256: `926fdd417854d4cf4fa4497ece65f4fce62d548e27b650dc8826f6505c9f0c40`.
