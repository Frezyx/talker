# talker

<a href="https://pub.dev/packages/talker"><img src="https://img.shields.io/pub/v/talker.svg" alt="Pub"></a>

Основной Dart-пакет для логирования и обработки ошибок. Работает в любом Dart-проекте — серверном, CLI или Flutter.

## Установка

```yaml
dependencies:
  talker: ^5.1.13
```

## Базовое логирование

```dart
import 'package:talker/talker.dart';

final talker = Talker();

// Логи с разными уровнями
talker.info('Приложение запущено');
talker.debug('Загрузка конфигурации...');
talker.warning('Кэш почти заполнен');
talker.error('Не удалось сохранить файл');
talker.critical('Соединение с БД потеряно!');
talker.verbose('Детальная информация трассировки');
talker.good('Операция завершена успешно!');
```

## Обработка ошибок

Обрабатывайте исключения и ошибки с полной поддержкой `StackTrace`:

```dart
try {
  throw Exception('Что-то пошло не так');
} catch (e, st) {
  talker.handle(e, st, 'Исключение при обработке данных');
}
```

Метод `handle()` автоматически различает типы `Exception` и `Error`.

## Продвинутое логирование

Используйте метод `log()` для максимального контроля:

```dart
talker.log(
  'Ошибка сервера',
  logLevel: LogLevel.critical,
  exception: Exception('Тайм-аут соединения'),
  stackTrace: stackTrace,
  pen: AnsiPen()..red(),
);
```

## TalkerSettings

Настройте поведение Talker через `TalkerSettings`:

```dart
final talker = Talker(
  settings: TalkerSettings(
    /// Включить/выключить все процессы Talker
    enabled: true,
    /// Включить/выключить сохранение логов в истории
    useHistory: true,
    /// Максимальное количество записей в истории
    maxHistoryItems: 1000,
    /// Включить/выключить вывод в консоль
    useConsoleLogs: true,
    /// Формат времени для логов
    timeFormat: TimeFormat.timeAndSeconds,
  ),
);
```

### Поля настроек

| Поле | Тип | По умолч. | Описание |
|------|-----|-----------|----------|
| `enabled` | `bool` | `true` | Главный переключатель всех операций |
| `useHistory` | `bool` | `true` | Сохранять логи в историю |
| `maxHistoryItems` | `int` | `1000` | Максимум записей в истории |
| `useConsoleLogs` | `bool` | `true` | Вывод логов в консоль |
| `timeFormat` | `TimeFormat` | `timeAndSeconds` | Формат временных меток |
| `titles` | `Map<String, String>` | _(по умолч.)_ | Пользовательские заголовки |
| `colors` | `Map<String, AnsiPen>` | _(по умолч.)_ | Пользовательские цвета |

## Пользовательские цвета

Задайте свой цвет для любого типа лога:

```dart
final talker = Talker(
  settings: TalkerSettings(
    colors: {
      TalkerLogType.httpResponse.key: AnsiPen()..red(),
      TalkerLogType.error.key: AnsiPen()..green(),
      TalkerLogType.info.key: AnsiPen()..blue(),

      // Пользовательские ключи
      'custom_log_key': AnsiPen()..yellow(),
    },
  ),
);
```

### Цвета по умолчанию

| Тип лога | Цвет |
|----------|------|
| `critical` | Красный |
| `error` | Красный |
| `exception` | Красный |
| `warning` | Жёлтый |
| `info` | Синий |
| `debug` | Серый |
| `verbose` | Серый |
| `httpRequest` | Розовый (xterm 219) |
| `httpResponse` | Зелёный (xterm 46) |
| `httpError` | Красный |
| `route` | Фиолетовый (xterm 135) |

## Пользовательские заголовки

Переопределите заголовки для любого типа лога:

```dart
final talker = Talker(
  settings: TalkerSettings(
    titles: {
      TalkerLogType.exception.key: 'Что угодно',
      TalkerLogType.error.key: 'О',
      TalkerLogType.info.key: 'и',

      // Пользовательские ключи
      'custom_log_key': 'Мой заголовок',
    },
  ),
);
```

## Пользовательские типы логов

Создайте собственный тип лога, расширив `TalkerLog`:

```dart
class HttpLog extends TalkerLog {
  HttpLog(String super.message);

  static const logKey = 'http_log';
  static final logTitle = 'HTTP';
  static final logPen = AnsiPen()..cyan();

  @override
  String get title => logTitle;

  @override
  String get key => logKey;

  @override
  AnsiPen get pen => logPen;
}

// Использование
talker.logCustom(HttpLog('GET /api/users — 200 OK'));
```

Полное руководство — [Пользовательские логи](/ru/guides/custom-logs).

## TalkerObserver

Наблюдайте за всеми событиями Talker извне — идеально для отправки данных во внешние сервисы:

```dart
class MyTalkerObserver extends TalkerObserver {
  @override
  void onError(TalkerError err) {
    // Отправить в Crashlytics, Sentry и т.д.
    super.onError(err);
  }

  @override
  void onException(TalkerException exception) {
    // Отправить в сервис отслеживания ошибок
    super.onException(exception);
  }

  @override
  void onLog(TalkerDataInterface log) {
    // Отправить в Grafana, бэкенд аналитики и т.д.
    super.onLog(log);
  }
}

final talker = Talker(observer: MyTalkerObserver());
```

См. руководство [Интеграция с Crashlytics](/ru/guides/crashlytics).

## Stream

Слушайте все события Talker через broadcast stream:

```dart
talker.stream.listen((data) {
  print('Новое событие: ${data.message}');
});
```

## История

Доступ к полной истории логов:

```dart
// Получить всю историю
final logs = talker.history;

// Очистить историю
talker.cleanHistory();
```

## Фильтрация

Используйте `TalkerFilter` для выбора конкретных логов:

```dart
final talker = Talker(
  filter: BaseTalkerFilter(
    titles: ['error', 'exception'],
    types: [TalkerError, TalkerException],
  ),
);
```

## Включение / Выключение

Управляйте Talker во время выполнения:

```dart
// Остановить всё логирование и обработку ошибок
talker.disable();

// Возобновить работу
talker.enable();
```

## Справка по API

Полная документация API доступна на [pub.dev](https://pub.dev/documentation/talker/latest/).
