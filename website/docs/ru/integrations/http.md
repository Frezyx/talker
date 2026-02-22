# HTTP Logger

<a href="https://pub.dev/packages/talker_http_logger"><img src="https://img.shields.io/pub/v/talker_http_logger.svg" alt="Pub"></a>

Лёгкий HTTP-логгер для [http_interceptor](https://pub.dev/packages/http_interceptor) на базе Talker.

## Установка

```yaml
dependencies:
  talker_http_logger: ^5.1.13
```

## Базовое использование

Добавьте `TalkerHttpLogger` в `InterceptedClient`:

```dart
import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker_http_logger/talker_http_logger.dart';

void main() async {
  final client = InterceptedClient.build(interceptors: [
    TalkerHttpLogger(
      settings: const TalkerHttpLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
      ),
    ),
  ]);

  await client.get("https://google.com".toUri());
}
```

## Использование с Talker

```dart
final talker = Talker();
final client = InterceptedClient.build(
  interceptors: [
    TalkerHttpLogger(talker: talker),
  ],
);
```

## Настройка

### Вывод curl-команды

```dart
TalkerHttpLoggerSettings(
  printRequestCurl: true,
)
```

### Скрытие конфиденциальных заголовков

```dart
TalkerHttpLoggerSettings(
  printRequestHeaders: true,
  printResponseHeaders: true,
  hiddenHeaders: {
    'authorization',
    'cookie',
  },
)
```

### Пользовательские цвета

```dart
TalkerHttpLoggerSettings(
  requestPen: AnsiPen()..blue(),
  responsePen: AnsiPen()..green(),
  errorPen: AnsiPen()..red(),
)
```

### Фильтрация

```dart
TalkerHttpLoggerSettings(
  requestFilter: (Request request) =>
      !request.url.path.contains('/secure'),
  responseFilter: (Response response) =>
      response.statusCode != 301,
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
