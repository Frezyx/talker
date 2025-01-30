import 'package:talker_http_logger/talker_http_logger_settings.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerHttpLoggerSettings', () {
    test(
        'Given a TalkerHttpLoggerSettings '
        'When instantiated without parameters '
        'Then it should have an empty set for hiddenHeaders', () {
      // Arrange & Act
      const settings = TalkerHttpLoggerSettings();

      // Assert
      expect(settings.hiddenHeaders, isEmpty);
    });

    test(
        'Given a TalkerHttpLoggerSettings '
        'When instantiated with a set of hidden headers '
        'Then it should correctly store the provided headers', () {
      // Arrange
      const hiddenHeaders = {'Authorization', 'Cookie'};

      // Act
      const settings = TalkerHttpLoggerSettings(hiddenHeaders: hiddenHeaders);

      // Assert
      expect(settings.hiddenHeaders, equals(hiddenHeaders));
    });

    test(
        'Given a TalkerHttpLoggerSettings '
        'When instantiated with an empty set '
        'Then it should store an empty set', () {
      // Arrange
      const hiddenHeaders = <String>{};

      // Act
      const settings = TalkerHttpLoggerSettings(hiddenHeaders: hiddenHeaders);

      // Assert
      expect(settings.hiddenHeaders, isEmpty);
    });
  });
}
