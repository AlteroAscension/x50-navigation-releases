# X50 Navigation 0.15.30-remote-adb-safe-local

- Добавлена opt-in удалённая ADB-диагностика: пользователь создаёт запрос на
  устройстве, владелец подтверждает короткую сессию в боте, а ADB остаётся
  доступным только через исходящий TLS-туннель и server loopback.
- Удалённое ADB стало безопасным для старых ядер: worker больше никогда не
  запускает, не останавливает и не перенастраивает dbd, TCP ADB или USB.
- Сессия использует только уже существующий локальный 127.0.0.1:5555;
  при его отсутствии она завершается fail-closed без изменения устройства.
- Cleanup удаляет только временный ключ и loopback firewall. Stale-state
  старых версий не может менять ADB-настройки при следующей загрузке.
- Карточка удалённой ADB-диагностики сокращена до статуса и управления;
  причина ошибки туннеля показывается только при ошибке.
- Проверены серверный broker, ключевая изоляция, SQLite consent-state,
  WebSocket loopback и упаковка Magisk-модуля.
- No activation required.
- Magisk module versionCode: 107
- SHA-256: `f3ac9db8fefa93d09d84d7a815646b894bf49fc7d80da4627205036eeabdff84`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.30-remote-adb-safe-local/x50-navigation-magisk-0.15.30-remote-adb-safe-local.zip