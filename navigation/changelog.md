# X50 Navigation 0.15.94-inertial-turn-fix

- Fixed inertial heading freeze on sharp intersection / off-route turns:
  - Dynamically expands allowed compass window up to 110° (instead of 25° cap) and tracking rate up to 45°/s when steering wheel and compass agree on turn direction (`turn_agrees`).
  - Suppressed `alignToFake` corridor pull and heading nudge when driver is actively steering (`|steer| > 20°`) or heading deviates (`|diffH| > 25°`), allowing natural dead-reckoning breakout into turns.
  - Removed 60m `hard_reanchor` teleporter; added clean `reanchor()` upon verified rebuild route recovery.
  - Enhanced `straight_recovery` with compass stability filter allowing recovery up to 50° residual when driving straight.
  - Graceful gear decoding fallback for emulator and rootless targets without ECarX gear property.
- Magisk module versionCode: 171
- SHA-256: `e72007d67fdf795c6468b7d49a0e8ed89fa5bb2a60b38a09b69b3457c8533585`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.94-inertial-turn-fix/x50-navigation-magisk-0.15.94-inertial-turn-fix.zip
