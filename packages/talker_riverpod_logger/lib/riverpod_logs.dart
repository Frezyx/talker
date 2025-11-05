import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod/misc.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

/// [Riverpod] add provider log model
class RiverpodAddLog extends TalkerLog {
  RiverpodAddLog({
    required this.provider,
    required this.value,
    required this.settings,
  }) : super("$provider initialized");

  final ProviderBase<Object?> provider;
  final Object? value;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String get key => TalkerKey.riverpodAdd;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write('\n${'INITIAL state: ${_printData(settings, value)}'}');
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
  }) : super("$provider updated");

  final ProviderBase<Object?> provider;
  final Object? previousValue;
  final Object? newValue;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String get key => TalkerKey.riverpodUpdate;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write('\n${'PREVIOUS state: ${_printData(settings, previousValue)}'}');
    sb.write('\n${'NEW state: ${_printData(settings, newValue)}'}');
    return sb.toString();
  }
}

/// [Riverpod] dispose provider log model
class RiverpodDisposeLog extends TalkerLog {
  RiverpodDisposeLog({required this.provider, required this.settings})
    : super("$provider disposed");

  final ProviderBase<Object?> provider;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String get key => TalkerKey.riverpodDispose;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
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
  }) : super("$provider failed");

  final ProviderBase<Object?> provider;
  final Object providerError;
  final StackTrace providerStackTrace;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String? get key => TalkerKey.riverpodFail;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write('\n${'ERROR: \n${_printFail(settings, providerError)}'}');
    sb.write('\n${'STACK TRACE: \n$providerStackTrace'}');
    return sb.toString();
  }
}

/// [Riverpod] mutation error log model
class RiverpodMutationErrorLog extends TalkerLog {
  RiverpodMutationErrorLog({
    required this.provider,
    required this.mutation,
    required this.mutationError,
    required this.mutationStackTrace,
    required this.settings,
  }) : super("$mutation of $provider failed");

  @override
  String? get key => TalkerKey.riverpodMutationFailed;

  final ProviderBase<Object?> provider;
  final Mutation<Object?> mutation;
  final Object mutationError;
  final StackTrace mutationStackTrace;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write('\n${'ERROR: \n${_printFail(settings, mutationError)}'}');
    sb.write('\n${'STACK TRACE: \n$mutationStackTrace'}');
    return sb.toString();
  }
}

/// [Riverpod] mutation reset log model
class RiverpodMutationResetLog extends TalkerLog {
  RiverpodMutationResetLog({
    required this.provider,
    required this.mutation,
    required this.settings,
  }) : super("$mutation of $provider reset");

  @override
  String? get key => TalkerKey.riverpodMutationReset;

  final ProviderBase<Object?> provider;
  final Mutation<Object?> mutation;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    return sb.toString();
  }
}

/// [Riverpod] mutation start log model
class RiverpodMutationStartLog extends TalkerLog {
  RiverpodMutationStartLog({
    required this.provider,
    required this.mutation,
    required this.settings,
  }) : super("$mutation of $provider started");

  @override
  String? get key => TalkerKey.riverpodMutationStart;

  final ProviderBase<Object?> provider;
  final Mutation<Object?> mutation;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    return sb.toString();
  }
}

/// [Riverpod] mutation success log model
class RiverpodMutationSuccessLog extends TalkerLog {
  RiverpodMutationSuccessLog({
    required this.provider,
    required this.mutation,
    required this.result,
    required this.settings,
  }) : super("$mutation of $provider succeeded");

  @override
  String? get key => TalkerKey.riverpodMutationSuccess;

  final ProviderBase<Object?> provider;
  final Mutation<Object?> mutation;
  final Object? result;
  final TalkerRiverpodLoggerSettings settings;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(displayTitleWithTime(timeFormat: timeFormat));
    sb.write('\n$message');
    sb.write('\n${'RESULT: ${_printData(settings, result)}'}');
    return sb.toString();
  }
}

String _printData(
  TalkerRiverpodLoggerSettings settings,
  Object? previousValue,
) {
  return settings.printStateFullData
      ? "\n$previousValue"
      : "${previousValue.runtimeType}";
}

String _printFail(TalkerRiverpodLoggerSettings settings, Object? fail) {
  return settings.printFailFullData ? "\n$fail" : "${fail.runtimeType}";
}
