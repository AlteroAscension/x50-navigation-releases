# X50 Navigation 0.15.83-steering-route-position

- Publishes the live FakeGPS position from a steering pose registered to the captured route. Route progress and calibrated physical distance remain the geographic and distance references.
- Seeds the steering pose from a fresh FakeGPS route point before a long shape match is available; route geometry bounds the position and bearing.
- Applies bounded steering-angle alignment on a matching short window. Good GPS retains priority for route-progress correction.
- With the steering off-route option enabled, a sustained lateral departure can continue the wheel trajectory from a trusted route anchor. Stale steering, anchor expiry, and route changes stop that mode.
- Adds route-aligned coordinates to recorded steering points and reports the active position model in diagnostics.
- Magisk module versionCode: 160
- SHA-256: `38f80f4a02b6267531b5a1e4098ee30dcc168eee03c7a4a39ddf06975384ffeb`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.83-steering-route-position/x50-navigation-magisk-0.15.83-steering-route-position.zip
