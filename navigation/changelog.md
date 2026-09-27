# X50 Navigation 0.15.86-inertial-navigation

- Adds an opt-in inertial trajectory based on calibrated vehicle distance, CAN steering and a guarded ESP32 compass heading.
- Anchors only to a reliable GPS fix or explicit "I am here" position and keeps recording across route changes.
- On a confirmed route departure, publishes inertial coordinates until the new captured route matches position and travel direction.
- Exports inertial points in trajectory snapshots for Home Assistant; the feature remains disabled by default.
- Magisk module versionCode: 163
- SHA-256: `6cb1e6feaaac5446e22aef202a8a7cf67701976a4e64903f207e6b16ffefcb2a`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.86-inertial-navigation/x50-navigation-magisk-0.15.86-inertial-navigation.zip