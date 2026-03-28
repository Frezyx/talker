# talker_logger

<a href="https://pub.dev/packages/talker_logger"><img src="https://img.shields.io/pub/v/talker_logger.svg" alt="Pub"></a>

Настраиваемый pretty-логгер для Dart/Flutter приложений. Может использоваться как самостоятельный пакет или как часть экосистемы Talker.

## Установка

```yaml
dependencies:
  talker_logger: ^5.1.13
```

## Базовое использование

```dart
import 'package:talker_logger/talker_logger.dart';

final logger = TalkerLogger();

logger.debug('debug');
logger.info('info');
logger.warning('warning');
logger.error('error');
logger.critical('critical');
logger.good('good');
logger.verbose('verbose');
```

## Произвольный уровень лога

```dart
logger.log('сообщение', level: LogLevel.info);
logger.log('цветной лог', pen: AnsiPen()..xterm(49));
```

## Уровни логов

| Уровень | Описание |
|---------|----------|
| `LogLevel.critical` | Критические ошибки, требующие немедленного внимания |
| `LogLevel.error` | Ошибки выполнения |
| `LogLevel.warning` | Потенциальные проблемы |
| `LogLevel.info` | Информационные сообщения |
| `LogLevel.debug` | Отладочная информация |
| `LogLevel.verbose` | Детальная информация трассировки |
| `LogLevel.good` | Позитивные статусные сообщения |

## Фильтрация

Фильтруйте логи, установив минимальный уровень:

```dart
final logger = TalkerLogger(
  settings: const TalkerLoggerSettings(
    level: LogLevel.critical,
  ),
);

// Это будет выведено
logger.critical('критическая ошибка');

// Это НЕ будет выведено (уровень ниже critical)
logger.info('информационное сообщение');
```

## Пользовательское форматирование

### Настройка встроенного форматтера

```dart
final logger = TalkerLogger(
  settings: TalkerLoggerSettings(
    colors: {
      LogLevel.critical: AnsiPen()..yellow(),
      LogLevel.error: AnsiPen()..yellow(),
      LogLevel.info: AnsiPen()..yellow(),
    },
    maxLineWidth: 20,
    lineSymbol: '#',
    enableColors: true,
  ),
);
```

### Свой форматтер

Реализуйте собственный `LoggerFormatter`:

```dart
class ColoredLoggerFormatter implements LoggerFormatter {
  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final msg = details.message?.toString() ?? '';
    final coloredMsg = msg
        .split('\n')
        .map((e) => details.pen.write(e))
        .toList()
        .join('\n');
    return coloredMsg;
  }
}

final logger = TalkerLogger(
  formatter: ColoredLoggerFormatter(),
);
```

## Настройки TalkerLoggerSettings

| Поле | Тип | По умолч. | Описание |
|------|-----|-----------|----------|
| `level` | `LogLevel` | `LogLevel.verbose` | Минимальный уровень для вывода |
| `enableColors` | `bool` | `true` | Использовать ANSI-цвета |
| `maxLineWidth` | `int` | `110` | Максимальная ширина линий-разделителей |
| `lineSymbol` | `String` | `'─'` | Символ для линий-разделителей |
| `colors` | `Map<LogLevel, AnsiPen>` | _(по умолч.)_ | Цвета для каждого уровня |

## Справка по API

Полная документация API доступна на [pub.dev](https://pub.dev/documentation/talker_logger/latest/).
