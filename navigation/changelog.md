# X50 Navigation 0.15.29-remote-adb-state-fix

- Добавлена opt-in удалённая ADB-диагностика: пользователь создаёт запрос на
  устройстве, владелец подтверждает короткую сессию в боте, а ADB остаётся
  доступным только через исходящий TLS-туннель и server loopback.
- Исправлен worker после отзыва, таймаута или перезагрузки remote-ADB сессии:
  очистка выполняется один раз, а legacy-состояние восстанавливает сохранённый
  wireless ADB вместо повторяющихся команд остановки dbd.
- Туннель запускается лишь после fail-closed подготовки dbd и временного
  ключа worker'ом; отсутствие файла db_keys на старом Android обработано.
- Карточка удалённой ADB-диагностики сокращена до статуса и управления;
  причина ошибки туннеля показывается только при ошибке.
- Проверены серверный broker, ключевая изоляция, SQLite consent-state,
  WebSocket loopback и упаковка Magisk-модуля.
- No activation required.
- Magisk module versionCode: 106
- SHA-256: `2f7386e75ece6b41f9e4e9a8dff26f0e7bbf7481869735f4e2b32b7828d47e9e`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.29-remote-adb-state-fix/x50-navigation-magisk-0.15.29-remote-adb-state-fix.zip