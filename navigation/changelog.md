# X50 Navigation 0.15.28-remote-adb-fix

- Добавлена opt-in удалённая ADB-диагностика: пользователь создаёт запрос на
  устройстве, владелец подтверждает короткую сессию в боте, а ADB остаётся
  доступным только через исходящий TLS-туннель и server loopback.
- Исправлено восстановление существующего wireless ADB после отзыва, таймаута
  или перезагрузки remote-ADB сессии. Worker сохраняет и восстанавливает
  persist/runtime/global конфигурацию dbd без открытия LAN-порта.
- Туннель запускается лишь после fail-closed подготовки dbd и временного
  ключа worker'ом; отсутствие файла db_keys на старом Android обработано.
- Проверены серверный broker, ключевая изоляция, SQLite consent-state,
  WebSocket loopback и упаковка Magisk-модуля.
- No activation required.
- Magisk module versionCode: 105
- SHA-256: `a359f39dae0298b4dabfe13e5ff26d5c5db3037d9f74e898c9e29e7ed91c9cab`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.28-remote-adb-fix/x50-navigation-magisk-0.15.28-remote-adb-fix.zip