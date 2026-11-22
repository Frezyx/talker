# Custom Error Messages

Show user-friendly error alerts and custom messages in your Flutter app using Talker's Flutter widgets.

## TalkerWrapper

The simplest way to show error alerts. Wrap your app (or a subtree) with `TalkerWrapper`:

```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

TalkerWrapper(
  talker: talker,
  options: const TalkerWrapperOptions(
    enableErrorAlerts: true,
    enableExceptionAlerts: true,
  ),
  child: MaterialApp(
    home: HomeScreen(),
  ),
)
```

Now whenever `talker.handle()` catches an exception or error, a SnackBar will automatically appear at the bottom of the screen.

## TalkerListener

For more control over what happens on each event, use `TalkerListener`:

```dart
TalkerListener(
  talker: talker,
  listener: (data) {
    if (data is TalkerException) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${data.displayMessage}'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Details',
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TalkerScreen(talker: talker),
                ),
              );
            },
          ),
        ),
      );
    }
  },
  child: MyApp(),
)
```

## TalkerBuilder

Build UI reactively based on log events:

```dart
TalkerBuilder(
  talker: talker,
  builder: (context, data) {
    final errors = data.whereType<TalkerError>().toList();
    final exceptions = data.whereType<TalkerException>().toList();

    if (errors.isEmpty && exceptions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.red.shade100,
      child: Text(
        '${errors.length + exceptions.length} errors occurred',
        style: const TextStyle(color: Colors.red),
      ),
    );
  },
)
```

## Custom Dialog on Error

Combine `TalkerListener` with a dialog for critical errors:

```dart
TalkerListener(
  talker: talker,
  listener: (data) {
    // Show dialog only for critical errors
    if (data is TalkerError && data.logLevel == LogLevel.critical) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Critical Error'),
          content: Text(data.displayMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TalkerScreen(talker: talker),
                  ),
                );
              },
              child: const Text('View Logs'),
            ),
          ],
        ),
      );
    }
  },
  child: MyApp(),
)
```

## Combining with Crashlytics

Use `TalkerWrapper` for user-visible alerts AND `TalkerObserver` for crash reporting simultaneously:

```dart
final talker = TalkerFlutter.init(
  observer: CrashlyticsTalkerObserver(FirebaseCrashlytics.instance),
);

TalkerWrapper(
  talker: talker,
  options: const TalkerWrapperOptions(
    enableErrorAlerts: true,
    enableExceptionAlerts: true,
  ),
  child: MaterialApp(home: HomeScreen()),
)
```

Now every error is:
1. Logged to the console
2. Saved in history
3. Shown to the user as a SnackBar
4. Sent to Crashlytics

## Best Practices

1. **Don't show technical details to users** — use `displayMessage` or create friendly messages rather than showing raw exception text.

2. **Use TalkerWrapper for development** — it's a quick way to see errors during development. Disable or replace with custom UI for production.

3. **Offer "View Logs" action** — let power users or testers open `TalkerScreen` from error alerts to investigate issues.

4. **Rate-limit alerts** — if errors fire rapidly, use a debounce mechanism to avoid flooding the user with SnackBars.
