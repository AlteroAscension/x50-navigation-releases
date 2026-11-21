# X50 Navigation 0.15.129

- USB GPS через Prolific `067B:23A3` теперь настраивается при подключении. Navigation определяет скорость UART по валидным NMEA-сообщениям и показывает её в диагностике.
- «Фикс OFF» выключает FakeGPS и удерживает паузу автофикса при новых GPS-координатах, перестроении маршрута и перезапуске службы. «Фикс ON» снимает паузу и возвращает обычную проверку привязки. Настройка автофикса сохраняется.

Обновление для Rooted (Magisk + LSPosed).


- Magisk module versionCode: 206
- SHA-256: `bcf4be0723bf43d48e8c2f58529bf2e6a70d961dde819c5d72577fb502e66f47`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.129-usb-autofix/x50-navigation-magisk-0.15.129-usb-autofix.zip
