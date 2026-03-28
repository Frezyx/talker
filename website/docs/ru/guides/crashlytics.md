# Интеграция с Crashlytics и Sentry

Используйте `TalkerObserver` для отправки ошибок, исключений и логов из Talker во внешние сервисы крэш-репортинга и аналитики.

## Как работает TalkerObserver

`TalkerObserver` слушает все события Talker и предоставляет колбэки для каждого типа:

```dart
abstract class TalkerObserver {
  void onError(TalkerError err) {}
  void onException(TalkerException exception) {}
  void onLog(TalkerDataInterface log) {}
}
```

- **onError** — вызывается когда `talker.handle()` перехватывает `Error`
- **onException** — вызывается когда `talker.handle()` перехватывает `Exception`
- **onLog** — вызывается для каждого события лога

## Firebase Crashlytics

```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:talker/talker.dart';

class CrashlyticsTalkerObserver extends TalkerObserver {
  CrashlyticsTalkerObserver(this.crashlytics);

  final FirebaseCrashlytics crashlytics;

  @override
  void onError(TalkerError err) {
    crashlytics.recordError(
      err.error,
      err.stackTrace,
      reason: err.message,
      fatal: err.logLevel == LogLevel.critical,
    );
  }

  @override
  void onException(TalkerException exception) {
    crashlytics.recordError(
      exception.exception,
      exception.stackTrace,
      reason: exception.message,
    );
  }

  @override
  void onLog(TalkerDataInterface log) {
    // Breadcrumbs для не-ошибочных событий
    crashlytics.log(log.generateTextMessage());
  }
}
```

### Настройка

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final crashlytics = FirebaseCrashlytics.instance;

  final talker = TalkerFlutter.init(
    observer: CrashlyticsTalkerObserver(crashlytics),
  );

  // Теперь все talker.handle() автоматически отправляются в Crashlytics
  try {
    throw Exception('Ошибка оплаты');
  } catch (e, st) {
    talker.handle(e, st, 'Ошибка обработки платежа');
    // ^ Логирование в консоль, сохранение в историю И отправка в Crashlytics
  }
}
```

## Sentry

```dart
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker/talker.dart';

class SentryTalkerObserver extends TalkerObserver {
  @override
  void onError(TalkerError err) {
    Sentry.captureException(
      err.error,
      stackTrace: err.stackTrace,
    );
  }

  @override
  void onException(TalkerException exception) {
    Sentry.captureException(
      exception.exception,
      stackTrace: exception.stackTrace,
    );
  }

  @override
  void onLog(TalkerDataInterface log) {
    Sentry.addBreadcrumb(
      Breadcrumb(
        message: log.generateTextMessage(),
        level: _mapLevel(log),
        timestamp: DateTime.now(),
      ),
    );
  }

  SentryLevel _mapLevel(TalkerDataInterface log) {
    if (log is TalkerError || log is TalkerException) {
      return SentryLevel.error;
    }
    return SentryLevel.info;
  }
}
```

### Настройка

```dart
void main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_SENTRY_DSN';
    },
    appRunner: () {
      final talker = TalkerFlutter.init(
        observer: SentryTalkerObserver(),
      );
      runApp(MyApp(talker: talker));
    },
  );
}
```

## Кастомный аналитический сервис

Тот же паттерн работает для любого сервиса:

```dart
class AnalyticsTalkerObserver extends TalkerObserver {
  AnalyticsTalkerObserver(this.analytics);

  final MyAnalyticsService analytics;

  @override
  void onError(TalkerError err) {
    analytics.trackError(
      name: 'app_error',
      error: err.error.toString(),
      stackTrace: err.stackTrace?.toString(),
    );
  }

  @override
  void onException(TalkerException exception) {
    analytics.trackError(
      name: 'app_exception',
      error: exception.exception.toString(),
      stackTrace: exception.stackTrace?.toString(),
    );
  }

  @override
  void onLog(TalkerDataInterface log) {
    analytics.trackEvent(
      name: 'app_log',
      params: {'message': log.message, 'title': log.title},
    );
  }
}
```

## Лучшие практики

1. **Не блокируйте основной поток** — SDK крэш-репортинга обрабатывают это внутренне, но будьте внимательны с тяжёлой обработкой в `onLog`.

2. **Используйте уровни логов разумно** — отправляйте только `error` и `critical` в Crashlytics, используйте `onLog` для breadcrumbs.

3. **Комбинируйте с TalkerWrapper** — показывайте ошибки пользователям через SnackBar, одновременно отправляя в крэш-сервис.

4. **Тестируйте observer** — пишите юнит-тесты, чтобы убедиться, что observer вызывается корректно.
