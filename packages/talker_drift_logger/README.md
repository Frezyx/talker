# talker_drift_logger
Lightweight and customizable [Drift](https://pub.dev/packages/drift) SQL logger on [talker](https://pub.dev/packages/talker) base.<br>
[Talker](https://github.com/Frezyx/talker) - Advanced exception handling and logging for dart/flutter applications 🚀

<p>
  <a href="https://github.com/Frezyx/talker"><img src="https://img.shields.io/github/stars/Frezyx/talker?style=social" alt="GitHub"></a>
  <a href="https://codecov.io/gh/Frezyx/talker"><img src="https://codecov.io/gh/Frezyx/talker/branch/master/graph/badge.svg" alt="codecov"></a>
  <a href="https://pub.dev/packages/talker_drift_logger"><img src="https://img.shields.io/pub/v/talker_drift_logger.svg" alt="Pub"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
</p>

## Getting started

### Add dependency
```yaml
dependencies:
  talker_drift_logger: ^5.0.0
```

### Usage
Attach `TalkerDriftLogger` via Drift interceptors and that's it:

```dart
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:talker_drift_logger/talker_drift_logger.dart';

final talker = Talker();

final executor = NativeDatabase.memory().interceptWith(
  TalkerDriftLogger(
    talker: talker,
    settings: const TalkerDriftLoggerSettings(
      printArgs: true,
      printResults: true,
    ),
  ),
);

// If you're using a GeneratedDatabase subclass:
final db = MyDatabase(executor);
```

You can also wrap an existing `DatabaseConnection` or use `runWithInterceptor` for scoped logging.

## Settings

`TalkerDriftLoggerSettings` gives you full control:

- enabled (default: true)
- logLevel (default: LogLevel.debug)
- printArgs / printResults
- resultRowLimit / resultMaxChars
- printTransaction / printBatch
- obfuscateColumns (case-insensitive)
- obfuscatePatterns (Pattern-based masking)
- queryPen / resultPen / errorPen / transactionPen / batchPen
- statementFilter / errorFilter
- resultPrinter / argsPrinter

Example:
```dart
TalkerDriftLogger(
  talker: talker,
  settings: const TalkerDriftLoggerSettings(
    printArgs: true,
    printResults: true,
    resultRowLimit: 50,
    resultMaxChars: 2000,
    obfuscateColumns: {'password', 'token'},
  ),
);
```

## Using with Talker
Provide your Talker instance if your app already uses Talker. In this case, all logs will go into your unified logging pipeline and UI (filters).

```dart
final talker = Talker();
final executor = NativeDatabase('app.db').interceptWith(TalkerDriftLogger(talker: talker));
```

## Notes

- Transactions (`begin`, `commit`, `rollback`) and batched statements are logged as well (configurable).
- This package prints pretty JSON, masks sensitive data, and limits result sizes to keep console clean.

## Additional information
The project is under development and ready for your pull-requests and issues 👍<br>
Thank you for support ❤️
