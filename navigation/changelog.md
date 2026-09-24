# X50 Navigation 0.15.76-steering-trajectory

- Added pure-sensor Virtual Trajectory Engine (Dead Reckoning bicycle model L=2.60m, G=15.5) utilizing fresh CAN ID 0x0E0 steering angle/rate, speed, and odometer.
- Records relative metric coordinates (x, y, theta) without premature GPS clamping.
- Persists session trajectories to JSON files and streams via REST endpoints (/api/trajectory/*).
- Embedded speed camera panel into 2GIS ETA block via verified native Qt adapter.
- Added opt-in 2GIS Dashboard Binder reads, disabled by default and independent of route geometry capture.
- Magisk module versionCode: 153
- SHA-256: `8af6d54056a505e58e3e6503282ac997ffc43fe867e98948bb53a8a3173ab752`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.76-steering-trajectory/x50-navigation-magisk-0.15.76-steering-trajectory.zip