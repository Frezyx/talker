# Custom Log Types

Talker allows you to create your own log types with full control over appearance, output format, and categorization.

## Why Custom Logs?

The built-in log types (`info`, `debug`, `warning`, etc.) cover most cases. But when you need domain-specific logs — like analytics events, business rule triggers, or custom HTTP formats — you can define your own.

## Creating a Custom Log

Extend the `TalkerLog` class:

```dart
import 'package:talker/talker.dart';

class AnalyticsLog extends TalkerLog {
  AnalyticsLog(String event, this.params) : super(event);

  final Map<String, dynamic> params;

  /// Unique key for this log type (used in settings, filters, etc.)
  @override
  String get key => 'analytics';

  /// Title shown in console and TalkerScreen
  @override
  String get title => 'ANALYTICS';

  /// Console color
  @override
  AnsiPen get pen => AnsiPen()..magenta();

  /// Customize the full message output
  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return '${super.generateTextMessage(timeFormat: timeFormat)}\n'
        'Event: $message\n'
        'Params: $params';
  }
}
```

## Using Custom Logs

Use `logCustom()` to send your custom log through Talker:

```dart
final talker = Talker();

talker.logCustom(
  AnalyticsLog('user_login', {'method': 'google', 'first_time': true}),
);
```

This will:
- Print a colored message to console with the title `ANALYTICS`
- Save the log in Talker's history
- Show the log in `TalkerScreen`
- Broadcast it via `talker.stream`
- Trigger `TalkerObserver.onLog()`

## Registering Custom Keys

To use custom colors and titles via `TalkerSettings`, register your custom key:

```dart
final talker = Talker(
  settings: TalkerSettings(
    // Register custom colors
    colors: {
      'analytics': AnsiPen()..magenta(),
    },
    // Register custom titles
    titles: {
      'analytics': 'ANALYTICS',
    },
  ),
);
```

::: tip
Settings-level colors and titles take priority over the log's own `pen` and `title` getters, allowing you to override them without changing the log class.
:::

## Real-World Examples

### Business Event Log

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
  AnsiPen get pen => AnsiPen()..xterm(220); // Gold

  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    var msg = super.generateTextMessage(timeFormat: timeFormat);
    if (revenue != null) msg += '\nRevenue: \$${revenue!.toStringAsFixed(2)}';
    if (userId != null) msg += '\nUser: $userId';
    return msg;
  }
}

talker.logCustom(
  BusinessEventLog('purchase_completed', revenue: 29.99, userId: 'usr_123'),
);
```

### Database Query Log

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
      ? (AnsiPen()..red())    // Slow query
      : (AnsiPen()..green()); // Normal query

  @override
  String generateTextMessage({TimeFormat? timeFormat}) {
    return '${super.generateTextMessage(timeFormat: timeFormat)}\n'
        'Query: $message\n'
        'Duration: ${duration.inMilliseconds}ms';
  }
}

talker.logCustom(
  DbQueryLog('SELECT * FROM users WHERE id = ?', Duration(milliseconds: 45)),
);
```

## Filtering Custom Logs

Custom logs can be filtered by type and title just like built-in logs:

```dart
final talker = Talker(
  filter: BaseTalkerFilter(
    titles: ['ANALYTICS', 'DB'],
  ),
);
```

## Viewing in TalkerScreen

Custom logs appear in `TalkerScreen` automatically. Their color in the Flutter UI can be customized via `TalkerScreenTheme`:

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
