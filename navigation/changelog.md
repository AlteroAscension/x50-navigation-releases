# X50 Navigation 0.15.15-internal-gnss

- Uses the standard Android mock-location model: select X50 Navigation in Developer options.
- Removes direct LSPosed location substitution inside Navigator; the remaining hook only observes location for manual start.
- Adds Internal GNSS input through the device receiver's NMEA stream, independent of the app's own mock publication.
- Removes the obsolete External GPS to Android setting; selected real sources publish through the single mock-location owner while FakeGPS is off.
- No activation required.
- Magisk module versionCode: 92
- SHA-256: `b7814b90c6f9738502aa13abf3c63cd56af382c15254ba4b768bccd9517c4333`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.15-internal-gnss/x50-navigation-magisk.zip