# Talker DevTools extension

DevTools extension for [Talker](https://github.com/Frezyx/talker): view app logs in a console inside Flutter DevTools.

## Build

From this directory (`packages/talker_flutter/extension`):

```bash
./build_extension.sh
```

Or use the official command (see [DevTools extensions](https://docs.flutter.dev/tools/devtools/extensions)):

```bash
flutter pub run devtools_extensions build_and_copy --source . --dest devtools
```

## Validate

To check the extension meets DevTools requirements:

```bash
flutter pub run devtools_extensions validate --package ../
```

## References

- [Dart & Flutter DevTools Extensions](https://blog.flutter.dev/dart-flutter-devtools-extensions-c8bc1aaf8e5f)
- [DevTools extensions (docs)](https://docs.flutter.dev/tools/devtools/extensions)
