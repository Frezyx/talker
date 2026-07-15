# Установка

## Выберите пакет

Talker — это модульная экосистема. Устанавливайте только то, что вам нужно:

### Для Dart-проектов

```yaml
dependencies:
  talker: ^5.1.13
```

### Для Flutter-проектов

```yaml
dependencies:
  talker_flutter: ^5.1.13
```

::: tip
`talker_flutter` уже включает `talker` как зависимость — не нужно добавлять оба пакета.
:::

### Пакеты интеграций

Добавьте любой из них рядом с основным пакетом:

```yaml
dependencies:
  # HTTP-логирование для Dio
  talker_dio_logger: ^5.1.13

  # HTTP-логирование для пакета http
  talker_http_logger: ^5.1.13

  # Логирование BLoC state management
  talker_bloc_logger: ^5.1.13

  # Логирование Riverpod state management
  talker_riverpod_logger: ^5.1.13

  # HTTP-логирование для Chopper
  talker_chopper_logger: ^5.1.13

  # gRPC-логирование
  talker_grpc_logger: ^5.1.13
```

## Запустите pub get

После добавления зависимостей выполните:

```bash
flutter pub get
# или для Dart-проектов
dart pub get
```

## Далее

Теперь, когда Talker установлен, переходите к [Быстрому старту](/ru/getting-started/quick-start)!
