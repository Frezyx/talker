import 'package:riverpod/riverpod.dart';

class TalkerRiverpodLoggerSettings {
  const TalkerRiverpodLoggerSettings({
    this.enabled = true,
    this.printProviderAdded = true,
    this.printProviderUpdated = true,
    this.printProviderDisposed = false,
    this.printProviderFailed = true,
    this.printStateFullData = true,
    this.providerFilter,
  });

  final bool enabled;
  final bool printProviderAdded;
  final bool printProviderUpdated;
  final bool printProviderDisposed;
  final bool printProviderFailed;
  final bool printStateFullData;
  final bool Function(ProviderBase<Object?> provider)? providerFilter;
}
