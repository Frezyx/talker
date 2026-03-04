import 'dart:convert';

import 'package:talker/talker.dart';
import 'package:talker_drift_logger/talker_drift_logger_settings.dart';

const _encoder = JsonEncoder.withIndent('  ');
const _hiddenValue = '*****';

String _truncate(String input, int? maxChars) {
  if (maxChars == null) return input;
  if (input.length <= maxChars) return input;
  return input.substring(0, maxChars) + '...';
}

String _maskPatterns(String value, Set<Pattern> patterns) {
  var v = value;
  for (final p in patterns) {
    v = v.replaceAll(p, _hiddenValue);
  }
  return v;
}

List<Object?> _maskArgs(
    List<Object?> args, TalkerDriftLoggerSettings settings) {
  if (args.isEmpty) return args;
  return args.map((e) {
    if (e is String) return _maskPatterns(e, settings.obfuscatePatterns);
    return e;
  }).toList(growable: false);
}

List<Map<String, Object?>> _maskRows(
  List<Map<String, Object?>> rows,
  TalkerDriftLoggerSettings settings,
) {
  if (rows.isEmpty) return rows;
  final lowerColumns =
      settings.obfuscateColumns.map((e) => e.toLowerCase()).toSet();
  return rows.map((row) {
    final mapped = <String, Object?>{};
    row.forEach((key, value) {
      final lowerKey = key.toLowerCase();
      if (lowerColumns.contains(lowerKey)) {
        mapped[key] = _hiddenValue;
      } else if (value is String) {
        mapped[key] = _maskPatterns(value, settings.obfuscatePatterns);
      } else {
        mapped[key] = value;
      }
    });
    return mapped;
  }).toList(growable: false);
}

String _prettyArgs(List<Object?> args, TalkerDriftLoggerSettings settings) {
  if (settings.argsPrinter != null) return settings.argsPrinter!(args);
  try {
    final masked = _maskArgs(args, settings);
    return _encoder.convert(masked);
  } catch (_) {
    return args.toString();
  }
}

String _prettyRows(
  List<Map<String, Object?>> rows,
  TalkerDriftLoggerSettings settings,
) {
  if (settings.resultPrinter != null) return settings.resultPrinter!(rows);
  try {
    final masked = _maskRows(rows, settings);
    return _encoder.convert(masked);
  } catch (_) {
    return rows.toString();
  }
}

class DriftQueryLog extends TalkerLog {
  DriftQueryLog(
    String statement, {
    required this.args,
    required this.settings,
  }) : super(statement);

  final List<Object?> args;
  final TalkerDriftLoggerSettings settings;

  @override
  AnsiPen get pen => settings.queryPen ?? (AnsiPen()..xterm(219));

  @override
  String get key => TalkerKey.driftQuery;

  @override
  LogLevel get logLevel => settings.logLevel;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    var msg = '[$title] $message';
    if (settings.printArgs && args.isNotEmpty) {
      msg += '\nArgs: ${_prettyArgs(args, settings)}';
    }
    return msg;
  }
}

class DriftResultLog extends TalkerLog {
  DriftResultLog(
    String statement, {
    required this.settings,
    this.durationMs,
    this.rowCount,
    this.rows,
    this.affected,
  }) : super(statement);

  final TalkerDriftLoggerSettings settings;
  final int? durationMs;
  final int? rowCount;
  final List<Map<String, Object?>>? rows;
  final int? affected;

  @override
  AnsiPen get pen => settings.resultPen ?? (AnsiPen()..xterm(46));

  @override
  String get key => TalkerKey.driftResult;

  @override
  LogLevel get logLevel => settings.logLevel;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    var msg = '[$title] $message';
    msg += '\nStatus: ok';
    if (durationMs != null) {
      msg += '\nTime: $durationMs ms';
    }
    if (affected != null) {
      msg += '\nAffected: $affected';
    }
    if (rowCount != null) {
      msg += '\nRows: $rowCount';
    }
    if (settings.printResults && rows != null && rows!.isNotEmpty) {
      var toShow = rows!;
      if (settings.resultRowLimit != null &&
          toShow.length > settings.resultRowLimit!) {
        toShow = toShow.sublist(0, settings.resultRowLimit!);
      }
      final pretty = _prettyRows(toShow, settings);
      msg += '\nData: ' + _truncate(pretty, settings.resultMaxChars);
    }
    return msg;
  }
}

class DriftErrorLog extends TalkerLog {
  DriftErrorLog(
    String statement, {
    required this.settings,
    required this.dbError,
    this.args = const [],
    this.durationMs,
  }) : super(statement);

  final TalkerDriftLoggerSettings settings;
  final Object dbError;
  final List<Object?> args;
  final int? durationMs;

  @override
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  @override
  String get key => TalkerKey.driftError;

  @override
  LogLevel get logLevel => LogLevel.error;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    var msg = '[$title] $message';
    if (durationMs != null) {
      msg += '\nTime: $durationMs ms';
    }
    msg += '\nMessage: ${dbError.toString()}';
    if (settings.printArgs && args.isNotEmpty) {
      msg += '\nArgs: ${_prettyArgs(args, settings)}';
    }
    return msg;
  }
}

class DriftTransactionLog extends TalkerLog {
  DriftTransactionLog(
    String action, {
    required this.settings,
    this.durationMs,
  }) : super(action);

  final TalkerDriftLoggerSettings settings;
  final int? durationMs;

  @override
  AnsiPen get pen => settings.transactionPen ?? (AnsiPen()..xterm(135));

  @override
  String get key => TalkerKey.driftTransaction;

  @override
  LogLevel get logLevel => settings.logLevel;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    var msg = '[$title] $message';
    if (durationMs != null) {
      msg += '\nTime: $durationMs ms';
    }
    return msg;
  }
}

class DriftBatchLog extends TalkerLog {
  DriftBatchLog(
    String message, {
    required this.settings,
  }) : super(message);

  final TalkerDriftLoggerSettings settings;

  @override
  AnsiPen get pen => settings.batchPen ?? (AnsiPen()..xterm(49));

  @override
  String get key => TalkerKey.driftBatch;

  @override
  LogLevel get logLevel => settings.logLevel;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return '[$title] $message';
  }
}
