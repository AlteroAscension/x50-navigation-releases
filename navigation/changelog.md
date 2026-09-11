# X50 Navigation 0.15.31-remote-adb-dynamic-port

- Добавлена opt-in удалённая ADB-диагностика: пользователь создаёт запрос на
  устройстве, владелец подтверждает короткую сессию в боте, а ADB остаётся
  доступным только через исходящий TLS-туннель и server loopback.
- Удалённое ADB стало безопасным для старых ядер: worker больше никогда не
  запускает, не останавливает и не перенастраивает dbd, TCP ADB или USB.
- Сессия использует только уже существующий локальный ADB endpoint;
  worker теперь read-only определяет его фактический runtime-порт; серверный
  session-порт независим от него. При отсутствии local adbd сессия
  завершается fail-closed без изменения устройства.
- Cleanup удаляет только временный ключ и loopback firewall. Stale-state
  старых версий не может менять ADB-настройки при следующей загрузке.
- Карточка удалённой ADB-диагностики сокращена до статуса и управления;
  причина ошибки туннеля показывается только при ошибке.
- Проверены серверный broker, ключевая изоляция, SQLite consent-state,
  WebSocket loopback и упаковка Magisk-модуля.
- No activation required.
- Magisk module versionCode: 108
- SHA-256: `826f85af3bfcb6beb94efd2466750200244203ad2df7f73043491397726bb32f`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.31-remote-adb-dynamic-port/x50-navigation-magisk-0.15.31-remote-adb-dynamic-port.zip