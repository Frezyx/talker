# Why Talker?

## The Problem

When developing Dart and Flutter applications, you need to:

- **Understand where errors occur** — as quickly as possible
- **Log application actions** — HTTP requests, state changes, navigation
- **Handle exceptions gracefully** — without crashing the app
- **Share error reports** — with your team or crash reporting services
- **Debug on real devices** — when there's no console available

Most existing logging solutions only cover part of this. You end up with scattered tools, inconsistent formats, and no unified view.

## The Solution

Talker provides a **single, unified system** for all logging and error handling in your application:

### Unified Logging

One API for everything — from simple debug messages to HTTP requests and state management events. All logs share the same format, history, and output.

### Rich Error Handling

Automatically distinguish between `Exception` and `Error` types, capture `StackTrace`, and route everything through a unified handler with `TalkerObserver`.

### Flutter-First UI

Built-in `TalkerScreen` lets you view, filter, search, and share all logs directly in your app — no console needed. `TalkerMonitor` gives you a quick status overview.

### Modular Integrations

Pick only what you need. Each integration (Dio, BLoC, Riverpod, etc.) is a separate lightweight package that plugs into the same Talker instance.

### Full Customization

Every aspect is customizable — colors, titles, log formats, filters. Create your own log types with full control over appearance and behavior.

## Key Features

| Feature | Talker |
|---------|--------|
| Log levels (info, debug, warning, error, critical, verbose, good) | ✅ |
| Colored console output | ✅ |
| Custom log types | ✅ |
| Exception/Error handling with StackTrace | ✅ |
| Log history | ✅ |
| In-app log viewer (TalkerScreen) | ✅ |
| In-app status monitor (TalkerMonitor) | ✅ |
| Error alerts UI (TalkerWrapper) | ✅ |
| Route/Navigation logging | ✅ |
| Dio HTTP logging | ✅ |
| http package logging | ✅ |
| BLoC state management logging | ✅ |
| Riverpod state management logging | ✅ |
| Chopper HTTP logging | ✅ |
| gRPC logging | ✅ |
| Observer for external services (Crashlytics, Sentry) | ✅ |
| Platform-optimized output (iOS, Android, Web) | ✅ |
| 100% test coverage | ✅ |
| Works with any state management | ✅ |

## Compatibility

- **Dart** >= 2.15
- **Flutter** >= 3.0
- **Platforms**: Android, iOS, Web, macOS, Windows, Linux
- **State management**: Works with any — BLoC, Riverpod, Provider, GetX, MobX, etc.
- **Crash reporting**: Firebase Crashlytics, Sentry, or any custom solution
