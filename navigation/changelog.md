# X50 Navigation 0.15.81-fakegps-steering-align

- Uses one calibrated physical-distance clock for FakeGPS progress and the steering trajectory; missing steering leaves a visible trace gap without losing travelled metres.
- Anchors trusted local steering shape to the latest published FakeGPS route point, including earlier GPS progress corrections, and rejects stale or previous-route anchors.
- Allows steering progress corrections only after stable interior matches with estimated uncertainty below FakeGPS uncertainty; retains GPS priority and bounded corrections.
- Adds distance and correction-confidence diagnostics. Technical details and offline trip evidence are in the private source documentation.
- Magisk module versionCode: 158
- SHA-256: `ffe69ae07b18504cd5c98efca219fad8f4c883ee8343061cb9e13116f5076355`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.81-fakegps-steering-align/x50-navigation-magisk-0.15.81-fakegps-steering-align.zip