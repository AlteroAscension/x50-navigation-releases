# X50 Navigation 0.15.110 — CAN485 / SD trip journal

- Поддержка угла руля от WeAct CAN485 через обновлённый Gateway, включая источник esp32_can485 и контроль свежести.
- Зеркало полного журнала поездки на SD платы: маршруты, входные измерения и решения инерциальной модели для анализа и воспроизведения.
- Ограниченная фоновая очередь, диагностика потерь и совместимость со старым Gateway.
- Для записи включить «Диагностика → Полный журнал поездок» и подключить CAN485 к Gateway по USB.
- Скорость и одометр читаются Navigation напрямую из ECarX; GPS берётся из выбранного источника.
- Защищённая сборка для Magisk + LSPosed (Rooted).

- Magisk module versionCode: 187
- SHA-256: `214d3d479708c5eac78bdb2df3ddabdcca321725f68c8255581279809dd974df`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.110-can485-sd-journal/x50-navigation-magisk-0.15.110-can485-sd-journal.zip
