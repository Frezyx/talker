import 'package:talker_logger/talker_logger.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerLoggerSettings', () {
    test('constructor sets correct values', () {
      final settings = TalkerLoggerSettings(
        colors: {LogLevel.error: AnsiPen()..red()},
        defaultTitle: 'CUSTOM_TITLE',
        level: LogLevel.error,
        lineSymbol: '*',
        maxLineWidth: 120,
        enableColors: false,
      );

      expect(settings.colors.length, equals(6));
      expect(settings.defaultTitle, equals('CUSTOM_TITLE'));
      expect(settings.level, equals(LogLevel.error));
      expect(settings.lineSymbol, equals('*'));
      expect(settings.maxLineWidth, equals(120));
      expect(settings.enableColors, isFalse);
    });

    test('copyWith returns a new instance with updated values', () {
      final originalSettings = TalkerLoggerSettings(
        colors: {LogLevel.error: AnsiPen()..red()},
        defaultTitle: 'CUSTOM_TITLE',
        level: LogLevel.error,
        lineSymbol: '*',
        maxLineWidth: 120,
        enableColors: false,
      );

      final updatedSettings = originalSettings.copyWith(
        colors: {LogLevel.debug: AnsiPen()..green()},
        defaultTitle: 'NEW_TITLE',
        level: LogLevel.debug,
        lineSymbol: '-',
        maxLineWidth: 80,
        enableColors: true,
      );

      expect(
        updatedSettings.colors.length,
        equals(6),
      );
      expect(updatedSettings.colors[LogLevel.debug], isNotNull);
      expect(updatedSettings.defaultTitle, equals('NEW_TITLE'));
      expect(updatedSettings.level, equals(LogLevel.debug));
      expect(updatedSettings.lineSymbol, equals('-'));
      expect(updatedSettings.maxLineWidth, equals(80));
      expect(updatedSettings.enableColors, isTrue);
    });
  });
}
