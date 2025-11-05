import 'package:meta/meta.dart';
import 'package:riverpod/src/framework.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

/// [Riverpod] logger on [Talker] base
///
/// [talker] field is the current [Talker] instance.
/// Provide your instance if your application uses [Talker] as the default logger
/// Common Talker instance will be used by default
base class TalkerRiverpodObserver extends ProviderObserver {
  TalkerRiverpodObserver({
    Talker? talker,
    this.settings = const TalkerRiverpodLoggerSettings(),
  }) {
    _talker = talker ?? Talker();
    _talker.settings.registerKeys([
      TalkerKey.riverpodAdd,
      TalkerKey.riverpodUpdate,
      TalkerKey.riverpodDispose,
      TalkerKey.riverpodFail,
    ]);
  }

  late Talker _talker;
  final TalkerRiverpodLoggerSettings settings;

  @override
  @mustCallSuper
  void didAddProvider(ProviderObserverContext context, Object? value) {
    super.didAddProvider(context, value);

    if (!settings.enabled || !settings.printProviderAdded) return;

    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) return;

    _talker.logCustom(
      RiverpodAddLog(
        provider: context.provider,
        value: value,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    super.didUpdateProvider(context, previousValue, newValue);

    if (!settings.enabled || !settings.printProviderUpdated) return;

    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) return;

    _talker.logCustom(
      RiverpodUpdateLog(
        provider: context.provider,
        previousValue: previousValue,
        newValue: newValue,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void didDisposeProvider(ProviderObserverContext context) {
    super.didDisposeProvider(context);
    if (!settings.enabled || !settings.printProviderDisposed) return;

    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) return;

    _talker.logCustom(
      RiverpodDisposeLog(provider: context.provider, settings: settings),
    );
  }

  @override
  @mustCallSuper
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    super.providerDidFail(context, error, stackTrace);
    if (!settings.enabled || !settings.printProviderFailed) return;
    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) return;

    try {
      final filtered = settings.didFailFilter?.call(error) ?? true;
      if (!filtered) return;
    } catch (_) {
      return;
    }

    _talker.logCustom(
      RiverpodFailLog(
        provider: context.provider,
        providerError: error,
        providerStackTrace: stackTrace,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void mutationError(
    ProviderObserverContext context,
    Mutation<Object?> mutation,
    Object error,
    StackTrace stackTrace,
  ) {
    super.mutationError(context, mutation, error, stackTrace);
    if (!settings.enabled || !settings.printMutationFailed) return;

    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) return;

    try {
      final filtered = settings.didFailMutationFilter?.call(error) ?? true;
      if (!filtered) return;
    } catch (_) {
      return;
    }

    _talker.logCustom(
      RiverpodMutationErrorLog(
        provider: context.provider,
        mutation: mutation,
        mutationError: error,
        mutationStackTrace: stackTrace,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void mutationReset(
    ProviderObserverContext context,
    Mutation<Object?> mutation,
  ) {
    super.mutationReset(context, mutation);
    if (!settings.enabled || !settings.printMutationReset) return;

    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) return;

    _talker.logCustom(
      RiverpodMutationResetLog(
        provider: context.provider,
        mutation: mutation,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void mutationStart(
    ProviderObserverContext context,
    Mutation<Object?> mutation,
  ) {
    super.mutationStart(context, mutation);

    if (!settings.enabled || !settings.printMutationStart) return;

    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) return;

    _talker.logCustom(
      RiverpodMutationStartLog(
        provider: context.provider,
        mutation: mutation,
        settings: settings,
      ),
    );
  }

  @override
  @mustCallSuper
  void mutationSuccess(
    ProviderObserverContext context,
    Mutation<Object?> mutation,
    Object? result,
  ) {
    super.mutationSuccess(context, mutation, result);

    if (!settings.enabled || !settings.printMutationSuccess) return;

    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) return;

    _talker.logCustom(
      RiverpodMutationSuccessLog(
        provider: context.provider,
        mutation: mutation,
        result: result,
        settings: settings,
      ),
    );
  }
}
