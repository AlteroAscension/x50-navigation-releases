# X50 Navigation 0.15.91-yandex-minimap

- Native Yandex Navigator style minimap overlay with 3D faceted yellow chevron cursor (#FFD600 / #E09800) matching native HUD styling.
- Selectable overlay shape: Floating Card (squircle) vs Circular Disc radar in Diagnostics settings.
- Native color palette: vibrant emerald green (#27C200) route polyline, warm amber (#FF9800) dead-reckoning trajectory, emerald dot (#32C649) for hardware GPS fix.
- Interactive gestures:
  - Single tap: cycle zoom radius (50m -> 100m -> 150m -> 250m -> 500m).
  - Double tap: toggle orientation (Heading-Up / Car-Up vs North-Up).
  - Long press: toggle center anchor between FakeGPS point and Inertial dead-reckoning point.
- Inertial dead-reckoning drift prevention:
  - Compass slew alignment at >= 15 km/h to eliminate angular heading drift.
  - Automatic re-anchor to current point when drift exceeds 75m.
  - Relaxed steering angle latency threshold for responsive curve tracing.
- Responsive settings UI (MainActivity) with new choice card for overlay shape and orientation modes.
- Magisk module versionCode: 168
- SHA-256: `85d31c53976c5f9e5f745a676caa8a5863e1df88efbbbe082748b2212de72d04`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.91-yandex-minimap/x50-navigation-magisk-0.15.91-yandex-minimap.zip