# X50 Navigation 0.15.73-steering-trajectory

- Added pure-sensor Virtual Trajectory Engine (Dead Reckoning bicycle model L=2.60m, G=15.5) utilizing fresh CAN ID 0x0E0 steering angle/rate, speed, and odometer.
- Records relative metric coordinates (x, y, theta) without premature GPS clamping.
- Persists session trajectories to JSON files and streams via REST endpoints (/api/trajectory/*).
- Embedded speed camera panel into 2GIS ETA block via verified native Qt adapter.
- Magisk module versionCode: 150
- SHA-256: `85be3e7399f28c44dded4c03bf1376490914297e04994541aa0ee5eb9bb25b2c`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.73-steering-trajectory/x50-navigation-magisk-0.15.73-steering-trajectory.zip