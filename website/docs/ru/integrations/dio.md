# Dio Logger

<a href="https://pub.dev/packages/talker_dio_logger"><img src="https://img.shields.io/pub/v/talker_dio_logger.svg" alt="Pub"></a>

Лёгкий и настраиваемый HTTP-логгер для [Dio](https://pub.dev/packages/dio) на базе Talker.

## Установка

```yaml
dependencies:
  talker_dio_logger: ^5.1.13
```

## Базовое использование

Добавьте `TalkerDioLogger` в интерцепторы Dio:

```dart
import 'package:talker_dio_logger/talker_dio_logger.dart';

final dio = Dio();
dio.interceptors.add(
  TalkerDioLogger(
    settings: const TalkerDioLoggerSettings(
      printRequestHeaders: true,
      printResponseHeaders: true,
      printResponseMessage: true,
    ),
  ),
);
```

## Использование с Talker

Передайте существующий экземпляр Talker для объединения всех логов:

```dart
final talker = Talker();
final dio = Dio();
dio.interceptors.add(TalkerDioLogger(talker: talker));
```

Теперь все HTTP-логи будут отображаться в `TalkerScreen`, истории и stream наряду с остальными логами.

## Настройка

### Переключение логирования запросов/ответов

```dart
TalkerDioLoggerSettings(
  printResponseData: true,
  printRequestData: false,
  printResponseHeaders: true,
  printRequestHeaders: false,
)
```

### Пользовательские цвета

```dart
TalkerDioLoggerSettings(
  requestPen: AnsiPen()..blue(),
  responsePen: AnsiPen()..green(),
  errorPen: AnsiPen()..red(),
)
```

### Фильтрация

Логировать только определённые запросы/ответы:

```dart
TalkerDioLoggerSettings(
  requestFilter: (RequestOptions options) =>
      !options.path.contains('/secure'),
  responseFilter: (response) =>
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
| `requestPen` | `AnsiPen?` | розовый | Цвет запросов в консоли |
| `responsePen` | `AnsiPen?` | зелёный | Цвет ответов в консоли |
| `errorPen` | `AnsiPen?` | красный | Цвет ошибок в консоли |
| `requestFilter` | `Function?` | `null` | Фильтр запросов |
| `responseFilter` | `Function?` | `null` | Фильтр ответов |
