# X50 Navigation 0.15.74-ha-trajectory

- Added pure-sensor Virtual Trajectory Engine (Dead Reckoning bicycle model L=2.60m, G=15.5) utilizing fresh CAN ID 0x0E0 steering angle/rate, speed, and odometer.
- Records relative metric coordinates (x, y, theta) without premature GPS clamping.
- Persists session trajectories to JSON files and streams via REST endpoints (/api/trajectory/*).
- Embedded speed camera panel into 2GIS ETA block via verified native Qt adapter.
- Magisk module versionCode: 151
- SHA-256: `0331466a425264562dfd11ceaf664645880d0c14ce7e31189600bdc9d35c5407`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.74-ha-trajectory/x50-navigation-magisk-0.15.74-ha-trajectory.zip