# X50 Navigation 0.15.99-sensor-timing

- Process ESP steering, compass and GPS measurements at their acquisition timestamps, including delayed history inside the retained trajectory window.
- Recompute affected trajectory segments while preserving odometer distance, motion gaps and manual anchors.
- Record ESP clock calibration and CAN/transport diagnostics in trip archives.
- Compatible with older Gateway feeds; install Gateway 2.30.18 and ESP 1.1.20 for full timestamp/history support.


- Magisk module versionCode: 176
- SHA-256: `6373bd419106bb60d1ae8106181fb1e4c3c3c8bb914a8b5c71ba2be01f525ca5`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.99-sensor-timing/x50-navigation-magisk-0.15.99-sensor-timing.zip
