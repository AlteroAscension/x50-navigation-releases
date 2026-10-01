# X50 Navigation 0.15.92-inertial-compass-fix

- Fixed sawtooth ("зуб пилы") inertial trajectory jumps and heading divergence:
  - Added strict residual threshold (<= 18.0°) to straight_recovery to prevent magnetic anomalies from pulling trajectory into ditch.
  - Slew rate towards compass reduced to gentle <= 2.0°/sec.
  - Eliminated alignToFake 30m-60m dead-zone for continuous soft corridor correction.
  - Made maximum step size dynamic (up to 35m+) to prevent dropping valid highway motion samples (>90 km/h) on GC/scheduling jitter.
- Integrated Belgee X50 factory 2D hard/soft iron compass calibration profile fallback when raw axes (X, Y, Z) are available.
- Added comprehensive alignToFake action diagnostics logging (`align_action`, `align_distance_m`, `align_diff_heading_deg`, `calibration_source`).
- Magisk module versionCode: 169
- SHA-256: `f100541a0c16b332a1cde2d3174610fbc16cbce3d39951a7b2218ed2fc304ab4`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.92-inertial-compass-fix/x50-navigation-magisk-0.15.92-inertial-compass-fix.zip

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
