import 'package:meta/meta.dart';
import 'package:riverpod/riverpod.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

/// [Riverpod] logger on [Talker] base
///
/// [talker] field is the current [Talker] instance.
/// Provide your instance if your application uses [Talker] as the default logger
/// Common Talker instance will be used by default
class TalkerRiverpodObserver extends ProviderObserver {
  TalkerRiverpodObserver({
    Talker? talker,
    this.settings = const TalkerRiverpodLoggerSettings(),
  }) {
    _talker = talker ?? Talker();
    _talker.settings.registerKeys(
      [
        TalkerKey.riverpodAdd,
        TalkerKey.riverpodUpdate,
        TalkerKey.riverpodDispose,
        TalkerKey.riverpodFail,
      ],
    );
  }

  late Talker _talker;
  final TalkerRiverpodLoggerSettings settings;

  @override
  @mustCallSuper
  void didAddProvider(
      ProviderObserverContext context,
      Object? value,
  ) {
    super.didAddProvider(context,value);
    if (!settings.enabled || !settings.printProviderAdded) {
      return;
    }
    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) {
      return;
    }
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
    if (!settings.enabled || !settings.printProviderUpdated) {
      return;
    }
    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) {
      return;
    }
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
  void didDisposeProvider(
      ProviderObserverContext context,
  ) {
    super.didDisposeProvider(context);
    if (!settings.enabled || !settings.printProviderDisposed) {
      return;
    }
    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) {
      return;
    }
    _talker.logCustom(
      RiverpodDisposeLog(
        provider: context.provider,
        settings: settings,
      ),
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
    if (!settings.enabled || !settings.printProviderFailed) {
      return;
    }
    final accepted = settings.providerFilter?.call(context.provider) ?? true;
    if (!accepted) {
      return;
    }

    try {
      final errorFiltered = settings.didFailFilter?.call(error) ?? true;
      if (!errorFiltered) {
        return;
      }
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
}
