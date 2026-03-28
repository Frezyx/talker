# BLoC Logger

<a href="https://pub.dev/packages/talker_bloc_logger"><img src="https://img.shields.io/pub/v/talker_bloc_logger.svg" alt="Pub"></a>

Лёгкий и настраиваемый логгер [BLoC](https://pub.dev/packages/bloc) state management на базе Talker.

## Установка

```yaml
dependencies:
  talker_bloc_logger: ^5.1.13
```

## Базовое использование

Установите `TalkerBlocObserver` как глобальный BLoC observer:

```dart
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

Bloc.observer = TalkerBlocObserver();
```

Готово! Все события BLoC, переходы, изменения состояний, создания и закрытия будут логироваться.

## Использование с Talker

```dart
final talker = Talker();
Bloc.observer = TalkerBlocObserver(talker: talker);
```

## Настройка

### Переключение типов событий

```dart
Bloc.observer = TalkerBlocObserver(
  settings: TalkerBlocLoggerSettings(
    enabled: true,
    printEvents: true,
    printTransitions: true,
    printChanges: true,
    printCreations: true,
    printClosings: true,
  ),
);
```

### Обрезка данных

По умолчанию выводятся полные данные. Можно обрезать:

```dart
Bloc.observer = TalkerBlocObserver(
  settings: TalkerBlocLoggerSettings(
    printEventFullData: false,
    printStateFullData: false,
  ),
);
```

### Фильтрация логов

Логировать только определённые BLoC:

```dart
Bloc.observer = TalkerBlocObserver(
  settings: TalkerBlocLoggerSettings(
    transitionFilter: (bloc, transition) =>
        bloc.runtimeType.toString() == 'AuthBloc',
    eventFilter: (bloc, event) =>
        bloc.runtimeType.toString() == 'AuthBloc',
  ),
);
```

## Справка по настройкам

| Поле | Тип | По умолч. | Описание |
|------|-----|-----------|----------|
| `enabled` | `bool` | `true` | Включить/выключить логирование |
| `printEvents` | `bool` | `true` | Логировать события |
| `printTransitions` | `bool` | `true` | Логировать переходы |
| `printChanges` | `bool` | `true` | Логировать изменения состояний |
| `printCreations` | `bool` | `true` | Логировать создания |
| `printClosings` | `bool` | `true` | Логировать закрытия |
| `printEventFullData` | `bool` | `true` | Полные данные событий |
| `printStateFullData` | `bool` | `true` | Полные данные состояний |
| `transitionFilter` | `Function?` | `null` | Фильтр переходов |
| `eventFilter` | `Function?` | `null` | Фильтр событий |
