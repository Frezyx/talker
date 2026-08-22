# Chopper Logger

<a href="https://pub.dev/packages/talker_chopper_logger"><img src="https://img.shields.io/pub/v/talker_chopper_logger.svg" alt="Pub"></a>

Лёгкий и настраиваемый HTTP-логгер для [Chopper](https://pub.dev/packages/chopper) на базе Talker.

## Установка

```yaml
dependencies:
  talker_chopper_logger: ^5.1.13
```

## Базовое использование

Добавьте `TalkerChopperLogger` как интерцептор Chopper:

```dart
import 'package:talker_chopper_logger/talker_chopper_logger.dart';

final chopper = ChopperClient(
  baseUrl: Uri.parse('https://api.example.com'),
  interceptors: [
    TalkerChopperLogger(
      settings: const TalkerChopperLoggerSettings(),
    ),
  ],
);
```

## Использование с Talker

```dart
final talker = Talker();
final chopper = ChopperClient(
  interceptors: [
    TalkerChopperLogger(talker: talker),
  ],
);
```

## Настройка

### Переключение логирования запросов/ответов

```dart
TalkerChopperLoggerSettings(
  printRequestData: true,
  printRequestHeaders: true,
  printResponseData: true,
  printResponseHeaders: true,
)
```

### Вывод curl-команды

```dart
TalkerChopperLoggerSettings(
  printRequestCurl: true,
)
```

### Скрытие конфиденциальных заголовков

```dart
TalkerChopperLoggerSettings(
  hiddenHeaders: {
    'authorization',
    'cookie',
    'x-api-key',
  },
)
```

### Пользовательские цвета

```dart
TalkerChopperLoggerSettings(
  requestPen: AnsiPen()..cyan(),
  responsePen: AnsiPen()..green(),
  errorPen: AnsiPen()..red(),
)
```

### Фильтрация

```dart
TalkerChopperLoggerSettings(
  requestFilter: (request) =>
      !request.url.path.contains('/health'),
  responseFilter: (response) =>
      response.statusCode != 304,
)
```

## Справка по настройкам

| Поле | Тип | По умолч. | Описание |
|------|-----|-----------|----------|
| `printRequestData` | `bool` | `true` | Выводить тело запроса |
| `printResponseData` | `bool` | `true` | Выводить тело ответа |
| `printRequestHeaders` | `bool` | `false` | Выводить заголовки запроса |
| `printResponseHeaders` | `bool` | `false` | Выводить заголовки ответа |
| `printResponseMessage` | `bool` | `true` | Выводить статус ответа |
| `printRequestCurl` | `bool` | `false` | Выводить curl-команду |
| `hiddenHeaders` | `Set<String>` | `{}` | Скрытые заголовки |
| `requestPen` | `AnsiPen?` | розовый | Цвет запросов |
| `responsePen` | `AnsiPen?` | зелёный | Цвет ответов |
| `errorPen` | `AnsiPen?` | красный | Цвет ошибок |
| `requestFilter` | `Function?` | `null` | Фильтр запросов |
| `responseFilter` | `Function?` | `null` | Фильтр ответов |
