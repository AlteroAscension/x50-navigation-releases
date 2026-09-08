# X50 Navigation 0.15.23-route-rebuild-lock

- GPS: добавлен постоянный переключатель «Запрет перестроения маршрута».
  При подтверждённом расхождении real GPS и FakeGPS он не отключает FakeGPS
  и не передаёт подменённую координату в Навигатор для перестроения.
- GPS-коррекции, обучение и запись real GPS сохраняются. При блокировке
  перехода диагностика фиксирует событие off_route_passthrough_blocked.
- Настройка выключена по умолчанию и сохраняется после перезапуска приложения,
  службы и устройства. Отключите её, чтобы вернуть автоматическое
  перестроение после реального схода с маршрута.
- Проверены сборка Magisk-модуля, регрессии GNSS/NMEA и persistence настройки
  на Android API 30. Поездку с этой сборкой проверяет пользователь.
- No activation required.
- Magisk module versionCode: 100
- SHA-256: `5702bc265bfd1b16c1f7933dff0485d34c0c93e64c5bfe70c0dce8f37d4d6cdb`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.23-route-rebuild-lock/x50-navigation-magisk.zip