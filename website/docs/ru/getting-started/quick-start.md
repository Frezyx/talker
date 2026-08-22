# Быстрый старт

## Базовое использование (Dart)

Создайте экземпляр Talker и начните логирование:

```dart
import 'package:talker/talker.dart';

final talker = Talker();

void main() {
  // Логи с разными уровнями
  talker.info('Приложение запущено');
  talker.debug('Загрузка конфигурации...');
  talker.warning('Кэш почти заполнен');
  talker.error('Не удалось сохранить файл');
  talker.critical('Соединение с базой данных потеряно!');
  talker.verbose('Детальная информация трассировки');
  talker.good('Операция выполнена успешно!');

  // Обработка исключений
  try {
    throw Exception('Что-то пошло не так');
  } catch (e, st) {
    talker.handle(e, st, 'Ошибка обработки данных');
  }
}
```

## Использование во Flutter

Для Flutter-приложений используйте `TalkerFlutter.init()` для оптимальной платформенной настройки:

```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

void main() {
  // Обработка исключений и ошибок
  try {
    // ваш код...
  } catch (e, st) {
    talker.handle(e, st, 'Исключение в ...');
  }

  // Логирование информации приложения
  talker.info('Приложение запущено');
  talker.critical('Хьюстон, у нас проблема!');
  talker.error('Сервис недоступен');
}
```

::: tip Почему TalkerFlutter.init()?
Большинство Flutter-пакетов для логирования либо обрезают сообщения в консоли, либо не могут отображать цветные сообщения на iOS. `TalkerFlutter.init()` использует оптимальный метод для каждой платформы:
- **Web** — `print()`
- **iOS / macOS** — `dart:developer.log`
- **Android / Windows / Linux** — `debugPrint`
:::

## Просмотр логов в приложении

Используйте `TalkerScreen` для просмотра логов прямо в приложении:

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => TalkerScreen(talker: talker),
  ),
);
```

## HTTP-логирование

Если вы используете Dio, добавьте логирование одной строкой:

```dart
final dio = Dio();
dio.interceptors.add(TalkerDioLogger(talker: talker));
```

## Что дальше?

- Узнайте о [возможностях Talker](/ru/packages/talker) — кастомные логи, цвета, заголовки, observer
- Изучите [Flutter-виджеты](/ru/packages/talker-flutter) — TalkerScreen, TalkerMonitor, TalkerWrapper
- Настройте [интеграции](/ru/integrations/dio) — Dio, BLoC, Riverpod и другие
- Прочитайте [руководства](/ru/guides/custom-logs) — пользовательские типы логов, интеграция с Crashlytics
