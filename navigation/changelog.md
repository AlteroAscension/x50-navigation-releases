# X50 Navigation 0.15.83-steering-route-position

- Adds a FakeGPS-route coordinate and route generation to each recorded steering trajectory point while route publication is active.
- Advances point coordinates between FakeGPS ticks with the same calibrated physical-distance clock; GPS corrections move the FakeGPS base without changing travelled length.
- Leaves raw sensor x/y intact for turn matching and departure detection, and omits geographic alignment during route loss or confirmed departure.
- Throttles incomplete steering fit diagnostics to the intended one-second interval.
- Magisk module versionCode: 160
- SHA-256: `848745c012b8c482a881bc84fb60962385b44044ba90d9607daa395eb972f925`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.83-steering-route-position/x50-navigation-magisk-0.15.83-steering-route-position.zip