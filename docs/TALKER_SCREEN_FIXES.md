# TalkerScreen Custom Log Fixes

This document describes the fixes implemented for TalkerScreen color and log display issues.

## Issues Fixed

### 1. Empty Logs for Custom Logs
**Problem**: When creating a custom log that overrides `generateTextMessage()`, the TalkerScreen would display empty log entries because it only used `generateTextMessage()` for HTTP logs.

**Solution**: Modified `data_card.dart` to detect when a custom log has overridden `generateTextMessage()` by comparing the generated output with the default implementation. If different, it uses the custom implementation.

**Example**:
```dart
class CustomLog extends TalkerLog {
  CustomLog(String message) : super(message);

  @override
  String generateTextMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return '[$title] $message\nExtra: some data';
  }
}
```

This log will now display its formatted message in TalkerScreen.

### 2. Incorrect Colors for Custom Logs
**Problem**: When creating a custom log that overrides the `pen` property, the colors were not displayed correctly in TalkerScreen because the UI only looked up colors by `key` in `TalkerScreenTheme.logColors`.

**Solution**: 
1. Created `AnsiColorConverter` utility that converts `AnsiPen` terminal colors to Flutter `Color` objects
2. Enhanced `getFlutterColor()` to use the converted pen color as a fallback when the key is not found in the theme

**Example**:
```dart
class CustomColorLog extends TalkerLog {
  CustomColorLog(String message) : super(message);

  @override
  AnsiPen get pen => AnsiPen()..magenta();

  @override
  String? get key => 'custom_log';
}
```

This log will now display in magenta color in TalkerScreen even if `'custom_log'` is not defined in `TalkerScreenTheme.logColors`.

## How It Works

### Color Lookup Priority
The color for a log in TalkerScreen is now determined in this order:
1. Look up by `key` in `TalkerScreenTheme.logColors`
2. Look up by `logLevel` (converted to key)
3. Convert `pen` (AnsiPen) to Flutter Color
4. Default to `Colors.grey`

### AnsiPen to Color Conversion
The `AnsiColorConverter` supports:
- Standard ANSI colors (red, green, blue, yellow, cyan, magenta, white, black)
- Bright ANSI colors
- xterm 256 color palette
- RGB colors

The converter parses ANSI escape codes from the pen and maps them to appropriate Flutter Color values.

## Migration Guide

### Before (Required Two Configurations)
```dart
// Configure colors for console
final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    colors: {
      'my_log': AnsiPen()..green(),
    },
  ),
);

// Also configure colors for UI
TalkerScreen(
  talker: talker,
  theme: TalkerScreenTheme(
    logColors: {
      'my_log': Colors.green,
    },
  ),
)
```

### After (Only One Configuration Needed)
```dart
// Configure colors for console (will be automatically used in UI)
final talker = TalkerFlutter.init(
  settings: TalkerSettings(
    colors: {
      'my_log': AnsiPen()..green(),
    },
  ),
);

// No need to duplicate color configuration
TalkerScreen(
  talker: talker,
  theme: TalkerScreenTheme(), // Uses pen color automatically
)
```

You can still override colors in `TalkerScreenTheme.logColors` if you want different colors in the UI vs console.

## Files Changed

- `packages/talker_flutter/lib/src/ui/widgets/data_card.dart` - Enhanced `_message` getter
- `packages/talker_flutter/lib/src/extensions/talker_data.dart` - Enhanced `getFlutterColor()` method
- `packages/talker_flutter/lib/src/utils/ansi_color_converter.dart` - New utility class
- `packages/talker_flutter/example/lib/custom_logs_example.dart` - Example custom logs
