import 'package:riverpod/misc.dart';

class TalkerRiverpodLoggerSettings {
  const TalkerRiverpodLoggerSettings({
    this.enabled = true,
    this.printProviderAdded = true,
    this.printProviderUpdated = true,
    this.printProviderDisposed = false,
    this.printProviderFailed = true,
    this.printStateFullData = true,
    this.printFailFullData = true,
    this.printMutationFailed = true,
    this.printMutationReset = false,
    this.printMutationStart = true,
    this.printMutationSuccess = true,
    this.didFailFilter,
    this.didFailMutationFilter,
    this.providerFilter,
  });

  final bool enabled;
  final bool printProviderAdded;
  final bool printProviderUpdated;
  final bool printProviderDisposed;
  final bool printProviderFailed;
  final bool printStateFullData;
  final bool printFailFullData;
  final bool printMutationFailed;
  final bool printMutationReset;
  final bool printMutationStart;
  final bool printMutationSuccess;
  final bool Function(Object error)? didFailFilter;
  final bool Function(Object? error)? didFailMutationFilter;
  final bool Function(ProviderBase<Object?> provider)? providerFilter;
}
