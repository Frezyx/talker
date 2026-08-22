# Installation

## Choose Your Package

Talker is a modular ecosystem. Install only what you need:

### For Dart-only projects

```yaml
dependencies:
  talker: ^5.1.13
```

### For Flutter projects

```yaml
dependencies:
  talker_flutter: ^5.1.13
```

::: tip
`talker_flutter` already includes `talker` as a dependency — you don't need to add both.
:::

### Integration packages

Add any of these alongside your main package:

```yaml
dependencies:
  # HTTP logging for Dio
  talker_dio_logger: ^5.1.13

  # HTTP logging for http package
  talker_http_logger: ^5.1.13

  # BLoC state management logging
  talker_bloc_logger: ^5.1.13

  # Riverpod state management logging
  talker_riverpod_logger: ^5.1.13

  # HTTP logging for Chopper
  talker_chopper_logger: ^5.1.13

  # gRPC logging
  talker_grpc_logger: ^5.1.13
```

## Run pub get

After adding the dependencies, run:

```bash
flutter pub get
# or for Dart-only projects
dart pub get
```

## Next Steps

Now that you have Talker installed, head over to the [Quick Start](/getting-started/quick-start) guide to start logging!
