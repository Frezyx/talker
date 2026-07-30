import 'package:talker/talker.dart' show AnsiPen, LogLevel;

/// Settings and customization for TalkerDriftLogger
class TalkerDriftLoggerSettings {
  const TalkerDriftLoggerSettings({
    this.enabled = true,
    this.logLevel = LogLevel.debug,
    this.printArgs = true,
    this.printResults = true,
    this.resultRowLimit = 50,
    this.resultMaxChars = 2000,
    this.printTransaction = true,
    this.printBatch = true,
    this.obfuscateColumns = const <String>{},
    this.obfuscatePatterns = const <Pattern>{},
    this.queryPen,
    this.resultPen,
    this.errorPen,
    this.transactionPen,
    this.batchPen,
    this.statementFilter,
    this.errorFilter,
    this.resultPrinter,
    this.argsPrinter,
  });

  /// Enable/disable logging
  final bool enabled;

  /// Common log level for non-error logs
  final LogLevel logLevel;

  /// Print SQL arguments
  final bool printArgs;

  /// Print SELECT results
  final bool printResults;

  /// Limit number of rows printed for SELECT results (null - unlimited)
  final int? resultRowLimit;

  /// Limit maximum characters printed for results (null - unlimited)
  final int? resultMaxChars;

  /// Log begin/commit/rollback
  final bool printTransaction;

  /// Log runBatched
  final bool printBatch;

  /// Columns to obfuscate in result rows (case-insensitive)
  final Set<String> obfuscateColumns;

  /// Patterns to obfuscate in args / results stringified values
  final Set<Pattern> obfuscatePatterns;

  /// Custom console colors
  final AnsiPen? queryPen;
  final AnsiPen? resultPen;
  final AnsiPen? errorPen;
  final AnsiPen? transactionPen;
  final AnsiPen? batchPen;

  /// Filters / formatters
  final bool Function(String statement, List<Object?> args)? statementFilter;
  final bool Function(Object error)? errorFilter;
  final String Function(List<Map<String, Object?>> rows)? resultPrinter;
  final String Function(List<Object?> args)? argsPrinter;

  TalkerDriftLoggerSettings copyWith({
    bool? enabled,
    LogLevel? logLevel,
    bool? printArgs,
    bool? printResults,
    int? resultRowLimit,
    int? resultMaxChars,
    bool? printTransaction,
    bool? printBatch,
    Set<String>? obfuscateColumns,
    Set<Pattern>? obfuscatePatterns,
    AnsiPen? queryPen,
    AnsiPen? resultPen,
    AnsiPen? errorPen,
    AnsiPen? transactionPen,
    AnsiPen? batchPen,
    bool Function(String statement, List<Object?> args)? statementFilter,
    bool Function(Object error)? errorFilter,
    String Function(List<Map<String, Object?>> rows)? resultPrinter,
    String Function(List<Object?> args)? argsPrinter,
  }) {
    return TalkerDriftLoggerSettings(
      enabled: enabled ?? this.enabled,
      logLevel: logLevel ?? this.logLevel,
      printArgs: printArgs ?? this.printArgs,
      printResults: printResults ?? this.printResults,
      resultRowLimit: resultRowLimit ?? this.resultRowLimit,
      resultMaxChars: resultMaxChars ?? this.resultMaxChars,
      printTransaction: printTransaction ?? this.printTransaction,
      printBatch: printBatch ?? this.printBatch,
      obfuscateColumns: obfuscateColumns ?? this.obfuscateColumns,
      obfuscatePatterns: obfuscatePatterns ?? this.obfuscatePatterns,
      queryPen: queryPen ?? this.queryPen,
      resultPen: resultPen ?? this.resultPen,
      errorPen: errorPen ?? this.errorPen,
      transactionPen: transactionPen ?? this.transactionPen,
      batchPen: batchPen ?? this.batchPen,
      statementFilter: statementFilter ?? this.statementFilter,
      errorFilter: errorFilter ?? this.errorFilter,
      resultPrinter: resultPrinter ?? this.resultPrinter,
      argsPrinter: argsPrinter ?? this.argsPrinter,
    );
  }
}
