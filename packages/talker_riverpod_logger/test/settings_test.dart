import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerRiverpodLoggerSettings', () {
    test('Default settings', () {
      final settings = TalkerRiverpodLoggerSettings();

      expect(settings.enabled, true);
      expect(settings.printProviderAdded, true);
      expect(settings.printProviderUpdated, true);
      expect(settings.printProviderDisposed, false);
      expect(settings.printProviderFailed, true);
      expect(settings.printStateFullData, true);
      expect(settings.providerFilter, isNull);
    });

    test('Custom settings', () {
      final settings = TalkerRiverpodLoggerSettings(
        enabled: false,
        printProviderAdded: false,
        printProviderUpdated: false,
        printProviderDisposed: true,
        printProviderFailed: false,
        printStateFullData: false,
        providerFilter: (provider) => true,
      );

      expect(settings.enabled, false);
      expect(settings.printProviderAdded, false);
      expect(settings.printProviderUpdated, false);
      expect(settings.printProviderDisposed, true);
      expect(settings.printProviderFailed, false);
      expect(settings.printStateFullData, false);
      expect(settings.providerFilter, isNotNull);
    });
  });
}
