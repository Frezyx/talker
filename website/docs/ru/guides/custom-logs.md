# Пользовательские типы логов

Talker позволяет создавать собственные типы логов с полным контролем над внешним видом, форматом вывода и категоризацией.

## Зачем свои логи?

Встроенные типы логов (`info`, `debug`, `warning` и т.д.) покрывают большинство случаев. Но когда нужны доменно-специфичные логи — аналитические события, бизнес-правила или кастомные форматы HTTP — можно определить свои.

## Создание пользовательского лога

Расширьте класс `TalkerLog`:

```dart
import 'package:talker/talker.dart';

class AnalyticsLog extends TalkerLog {
  AnalyticsLog(String event, this.params) : super(event);

  final Map<String, dynamic> params;

  /// Уникальный ключ для этого типа лога
  @override
  String get key => 'analytics';

  /// Заголовок в консоли и TalkerScreen
  @override
  String get title => 'ANALYTICS';

  /// Цвет в консоли
  @override
  AnsiPen get pen => AnsiPen()..magenta();

  /// Полный формат сообщения
  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return '${super.generateTextMessage(timeFormat: timeFormat)}\n'
        'Event: $message\n'
        'Params: $params';
  }
}
```

## Использование

Используйте `logCustom()` для отправки пользовательского лога:

```dart
final talker = Talker();

talker.logCustom(
  AnalyticsLog('user_login', {'method': 'google', 'first_time': true}),
);
```

Это:
- Выведет цветное сообщение в консоль с заголовком `ANALYTICS`
- Сохранит лог в истории Talker
- Покажет в `TalkerScreen`
- Передаст через `talker.stream`
- Вызовет `TalkerObserver.onLog()`

## Регистрация кастомных ключей

Для использования кастомных цветов и заголовков через `TalkerSettings`:

```dart
final talker = Talker(
  settings: TalkerSettings(
    colors: {
      'analytics': AnsiPen()..magenta(),
    },
    titles: {
      'analytics': 'ANALYTICS',
    },
  ),
);
```

::: tip
Цвета и заголовки из настроек имеют приоритет над геттерами `pen` и `title` самого лога, что позволяет переопределять их без изменения класса.
:::

## Примеры из практики

### Лог бизнес-события

```dart
class BusinessEventLog extends TalkerLog {
  BusinessEventLog(String eventName, {this.revenue, this.userId})
      : super(eventName);

  final double? revenue;
  final String? userId;

  @override
  String get key => 'business_event';

  @override
  String get title => 'BUSINESS';

  @override
  AnsiPen get pen => AnsiPen()..xterm(220); // Золотой

  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    var msg = super.generateTextMessage(timeFormat: timeFormat);
    if (revenue != null) msg += '\nВыручка: \$${revenue!.toStringAsFixed(2)}';
    if (userId != null) msg += '\nПользователь: $userId';
    return msg;
  }
}

talker.logCustom(
  BusinessEventLog('purchase_completed', revenue: 29.99, userId: 'usr_123'),
);
```

### Лог SQL-запроса

```dart
class DbQueryLog extends TalkerLog {
  DbQueryLog(String query, this.duration) : super(query);

  final Duration duration;

  @override
  String get key => 'db_query';

  @override
  String get title => 'DB';

  @override
  AnsiPen get pen => duration.inMilliseconds > 1000
      ? (AnsiPen()..red())    // Медленный запрос
      : (AnsiPen()..green()); // Нормальный

  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return '${super.generateTextMessage(timeFormat: timeFormat)}\n'
        'Запрос: $message\n'
        'Длительность: ${duration.inMilliseconds}мс';
  }
}
```

## Фильтрация

Пользовательские логи фильтруются так же, как встроенные:

```dart
final talker = Talker(
  filter: BaseTalkerFilter(
    titles: ['ANALYTICS', 'DB'],
  ),
);
```

## Отображение в TalkerScreen

Цвет в Flutter UI можно настроить через `TalkerScreenTheme`:

```dart
TalkerScreen(
  talker: talker,
  theme: const TalkerScreenTheme(
    logColors: {
      'analytics': Color(0xFFE040FB),
      'db_query': Color(0xFF4CAF50),
    },
  ),
)
```
