# X50 Navigation 0.15.21-internal-gps-fix

- Исправлено зависание Internal GPS на ГУ: штатные координаты больше не
  публикуются повторно через mock GPS и не отключают физический приёмник.
- Magisk автоматически выдаёт разрешение на точную геолокацию.
- Служба повторяет регистрацию GPS/NMEA и статуса спутников, если запустилась
  до выдачи разрешения. Выбор mock-приложения остаётся за пользователем.
- Проверено на SX11A3 после перезагрузки: Internal продолжает получать свежие
  координаты и статус спутников при выбранном mock-приложении X50 Navigation.
- Проверка выполнена с выключенным FakeGPS. Непрерывные коррекции от Internal
  при активном FakeGPS на этой прошивке пока не подтверждены.
- No activation required.
- Magisk module versionCode: 98
- SHA-256: `5881bd59356d681553eb0cef5af9b040504824aaa406d022b5f81fdbb8b82148`
- Module ZIP: https://raw.githubusercontent.com/AlteroAscension/x50-navigation-releases/main/navigation/releases/navigation-v0.15.21-internal-gps-fix/x50-navigation-magisk.zip