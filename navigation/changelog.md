# X50 Navigation 0.12.11-gps-time-anchor

- Corrects a stable Relay↔head-unit GPS timestamp offset after four consistent
  fixes; genuine delayed or inconsistent packets remain rejected.
- Makes the native GPS badge reflect whether a fix is truly eligible for
  FakeGPS start/correction. Fake OFF remains neutral grey.
- Prevents double ON/TOGGLE from using an old Navigator cursor or falling back
  to an old route-start coordinate.
- Protected binary Magisk module; activation required.
