# Riverpod Logger

<a href="https://pub.dev/packages/talker_riverpod_logger"><img src="https://img.shields.io/pub/v/talker_riverpod_logger.svg" alt="Pub"></a>

Лёгкий и настраиваемый логгер [Riverpod](https://pub.dev/packages/riverpod) state management на базе Talker.

## Установка

```yaml
dependencies:
  talker_riverpod_logger: ^5.1.13
```

## Базовое использование

Добавьте `TalkerRiverpodObserver` в `ProviderScope`:

```dart
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

runApp(
  ProviderScope(
    observers: [TalkerRiverpodObserver()],
    child: MyApp(),
  ),
);
```

Все события жизненного цикла провайдеров — add, update, dispose и fail — будут логироваться автоматически.

## Использование с Talker

```dart
final talker = Talker();

runApp(
  ProviderScope(
    observers: [TalkerRiverpodObserver(talker: talker)],
    child: MyApp(),
  ),
);
```

## Настройка

### Переключение типов событий

```dart
TalkerRiverpodObserver(
  settings: TalkerRiverpodLoggerSettings(
    enabled: true,
    printProviderAdded: true,
    printProviderUpdated: true,
    printProviderDisposed: true,
    printProviderFailed: true,
  ),
)
```

### Обрезка данных

```dart
TalkerRiverpodObserver(
  settings: TalkerRiverpodLoggerSettings(
    printStateFullData: false,
  ),
)
```

### Фильтрация логов

```dart
TalkerRiverpodObserver(
  settings: TalkerRiverpodLoggerSettings(
    providerFilter: (provider) =>
        provider.name?.contains('auth') ?? false,
  ),
)
```

## Справка по настройкам

| Поле | Тип | По умолч. | Описание |
|------|-----|-----------|----------|
| `enabled` | `bool` | `true` | Включить/выключить логирование |
| `printProviderAdded` | `bool` | `true` | Логировать добавление провайдеров |
| `printProviderUpdated` | `bool` | `true` | Логировать обновление провайдеров |
| `printProviderDisposed` | `bool` | `true` | Логировать удаление провайдеров |
| `printProviderFailed` | `bool` | `true` | Логировать ошибки провайдеров |
| `printStateFullData` | `bool` | `true` | Полные данные состояний |
| `providerFilter` | `Function?` | `null` | Фильтр провайдеров |
