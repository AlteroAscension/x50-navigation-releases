# X50 Navigation 0.15.27-ntp-result

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
- Magisk module versionCode: 104
- SHA-256: `2057cc7f6aa9dae392bab16e58cd964877e076dfc4de1bb6b0ef24f77556f772`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.27-ntp-result/x50-navigation-magisk-0.15.27-ntp-result.zip