# X50 Navigation 0.12.21-adaptive-limit-alerts

- Progress ring of Navigator's mini-player now stays inside the original
  Play/Pause button and does not enlarge its visual bounds.
- The expanded limit card uses the exact same FakeGPS state label and colour as
  the compact native strip.
- Adaptive warning distance applies to both cameras and upcoming limit changes:
  it accounts for vehicle speed and the difference between current and future
  limits. Minimum and maximum distance are configurable.
- Added speed hysteresis for the overspeed threshold: a shown warning remains
  visible until speed drops below the configured threshold minus the selected
  safety margin, avoiding rapid flicker near the boundary.
- Protected binary Magisk module; activation required.
- Magisk module versionCode: 47.
- SHA-256: `cb3d15536b11282800835bd3146511d74e70e2981312b022195b13c9b844a771`
