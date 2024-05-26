import 'package:riverpod/riverpod.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

/// [Riverpod] add provider log model
class RiverpodAddLog extends TalkerLog {
  RiverpodAddLog({
    required this.provider,
    required this.value,
    required this.settings,
  }) : super('${provider.runtimeType} initialized');

  final ProviderBase<Object?> provider;
  final Object? value;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String get key => TalkerLogType.riverpodAdd.key;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime);
    sb.write('\n$message');
    sb.write(
        '\n${'INITIAL state: ${settings.printStateFullData ? '\n$value' : value.runtimeType}'}');
    return sb.toString();
  }
}

/// [Riverpod] update provider log model
class RiverpodUpdateLog extends TalkerLog {
  RiverpodUpdateLog({
    required this.provider,
    required this.previousValue,
    required this.newValue,
    required this.settings,
  }) : super('${provider.runtimeType} updated');

  final ProviderBase<Object?> provider;
  final Object? previousValue;
  final Object? newValue;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String get key => TalkerLogType.riverpodUpdate.key;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime);
    sb.write('\n$message');
    sb.write(
        '\n${'PREVIOUS state: ${settings.printStateFullData ? '\n$previousValue' : previousValue.runtimeType}'}');
    sb.write(
        '\n${'NEW state: ${settings.printStateFullData ? '\n$newValue' : newValue.runtimeType}'}');
    return sb.toString();
  }
}

/// [Riverpod] dispose provider log model
class RiverpodDisposeLog extends TalkerLog {
  RiverpodDisposeLog({
    required this.provider,
    required this.settings,
  }) : super('${provider.runtimeType} disposed');

  final ProviderBase<Object?> provider;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String get key => TalkerLogType.riverpodDispose.key;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime);
    sb.write('\n$message');
    return sb.toString();
  }
}

/// [Riverpod] fail provider log model
class RiverpodFailLog extends TalkerLog {
  RiverpodFailLog({
    required this.provider,
    required this.providerError,
    required this.providerStackTrace,
    required this.settings,
  }) : super('${provider.runtimeType} failed');

  final ProviderBase<Object?> provider;
  final Object providerError;
  final StackTrace providerStackTrace;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String? get key => TalkerLogType.riverpodFail.key;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return _createMessage();
  }

  String _createMessage() {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime);
    sb.write('\n$message');
    sb.write('\n${'ERROR: \n$providerError'}');
    sb.write('\n${'STACK TRACE: \n$providerStackTrace'}');
    return sb.toString();
  }
}
