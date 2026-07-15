# gRPC Logger

<a href="https://pub.dev/packages/talker_grpc_logger"><img src="https://img.shields.io/pub/v/talker_grpc_logger.svg" alt="Pub"></a>

Лёгкий и настраиваемый [gRPC](https://pub.dev/packages/grpc) логгер на базе Talker.

## Установка

```yaml
dependencies:
  talker_grpc_logger: ^5.1.13
```

## Базовое использование

Добавьте `TalkerGrpcLogger` как gRPC-интерцептор:

```dart
import 'package:talker_grpc_logger/talker_grpc_logger.dart';

final channel = ClientChannel(
  'localhost',
  port: 50051,
  options: ChannelOptions(
    credentials: const ChannelCredentials.insecure(),
  ),
);

final client = YourServiceClient(
  channel,
  interceptors: [TalkerGrpcLogger()],
);
```

## Использование с Talker

```dart
final talker = Talker();
final client = YourServiceClient(
  channel,
  interceptors: [
    TalkerGrpcLogger(talker: talker),
  ],
);
```

## Настройка

### Обфускация токенов

gRPC-метаданные часто содержат конфиденциальные токены. Talker может их обфусцировать:

```dart
TalkerGrpcLogger(
  settings: TalkerGrpcLoggerSettings(
    // Токен будет отображаться как "eyJh***" вместо полного значения
    printRequestHeaders: true,
    hideTokens: true,
  ),
)
```

### Переключение логирования запросов/ответов

```dart
TalkerGrpcLoggerSettings(
  printRequestData: true,
  printResponseData: true,
  printRequestHeaders: true,
  printResponseHeaders: true,
)
```

### Пользовательские цвета

```dart
TalkerGrpcLoggerSettings(
  requestPen: AnsiPen()..cyan(),
  responsePen: AnsiPen()..green(),
  errorPen: AnsiPen()..red(),
)
```

## Справка по настройкам

| Поле | Тип | По умолч. | Описание |
|------|-----|-----------|----------|
| `printRequestData` | `bool` | `true` | Выводить данные запроса |
| `printResponseData` | `bool` | `true` | Выводить данные ответа |
| `printRequestHeaders` | `bool` | `false` | Выводить метаданные запроса |
| `printResponseHeaders` | `bool` | `false` | Выводить трейлеры ответа |
| `hideTokens` | `bool` | `false` | Обфусцировать токены |
| `requestPen` | `AnsiPen?` | розовый | Цвет запросов |
| `responsePen` | `AnsiPen?` | зелёный | Цвет ответов |
| `errorPen` | `AnsiPen?` | красный | Цвет ошибок |
