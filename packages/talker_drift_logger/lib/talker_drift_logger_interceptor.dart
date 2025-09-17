import 'dart:async';

import 'package:drift/drift.dart';
import 'package:talker/talker.dart';
import 'package:talker_drift_logger/drift_logs.dart';
import 'package:talker_drift_logger/talker_drift_logger_settings.dart';

/// Drift SQL logger on Talker base
class TalkerDriftLogger extends QueryInterceptor {
  TalkerDriftLogger({
    Talker? talker,
    this.settings = const TalkerDriftLoggerSettings(),
  }) {
    _talker = talker ?? Talker();
    _talker.settings.registerKeys(const [
      TalkerKey.driftQuery,
      TalkerKey.driftResult,
      TalkerKey.driftError,
      TalkerKey.driftTransaction,
      TalkerKey.driftBatch,
    ]);
  }

  late final Talker _talker;

  /// Settings and customization
  final TalkerDriftLoggerSettings settings;

  Future<T> _run<T>(
    String description,
    FutureOr<T> Function() operation, {
    void Function(int durationMs)? onDone,
    void Function(Object error, int durationMs)? onError,
  }) async {
    final sw = Stopwatch()..start();
    try {
      final res = await operation();
      sw.stop();
      onDone?.call(sw.elapsedMilliseconds);
      return res;
    } catch (e) {
      sw.stop();
      onError?.call(e, sw.elapsedMilliseconds);
      rethrow;
    }
  }

  bool _accept(String statement, List<Object?> args) {
    if (!settings.enabled) return false;
    final filter = settings.statementFilter;
    if (filter == null) return true;
    try {
      return filter(statement, args);
    } catch (e, st) {
      // Surface filter configuration issues for easier debugging
      _talker.handle(e, st, 'Error in Drift statementFilter');
      return false;
    }
  }

  bool _acceptError(Object error) {
    if (!settings.enabled) return false;
    final filter = settings.errorFilter;
    if (filter == null) return true;
    try {
      return filter(error);
    } catch (e, st) {
      // Surface filter configuration issues for easier debugging
      _talker.handle(e, st, 'Error in Drift errorFilter');
      return false;
    }
  }

  @override
  TransactionExecutor beginTransaction(QueryExecutor parent) {
    if (settings.enabled && settings.printTransaction) {
      _talker.logCustom(DriftTransactionLog('begin', settings: settings));
    }
    return super.beginTransaction(parent);
  }

  @override
  Future<void> commitTransaction(TransactionExecutor inner) {
    if (!settings.enabled || !settings.printTransaction) {
      return super.commitTransaction(inner);
    }
    return _run<void>(
      'commit',
      () => super.commitTransaction(inner),
      onDone: (ms) => _talker.logCustom(
        DriftTransactionLog('commit', settings: settings, durationMs: ms),
      ),
      onError: (err, ms) {
        if (_acceptError(err)) {
          _talker.logCustom(
            DriftErrorLog('commit', settings: settings, dbError: err, durationMs: ms),
          );
        }
      },
    );
  }

  @override
  Future<void> rollbackTransaction(TransactionExecutor inner) {
    if (!settings.enabled || !settings.printTransaction) {
      return super.rollbackTransaction(inner);
    }
    return _run<void>(
      'rollback',
      () => super.rollbackTransaction(inner),
      onDone: (ms) => _talker.logCustom(
        DriftTransactionLog('rollback', settings: settings, durationMs: ms),
      ),
      onError: (err, ms) {
        if (_acceptError(err)) {
          _talker.logCustom(
            DriftErrorLog('rollback', settings: settings, dbError: err, durationMs: ms),
          );
        }
      },
    );
  }

  @override
  Future<void> runBatched(QueryExecutor executor, BatchedStatements statements) {
    if (settings.enabled && settings.printBatch) {
      _talker.logCustom(
        DriftBatchLog('batch with ${statements.statements.length} statements',
            settings: settings),
      );
    }
    return super.runBatched(executor, statements);
  }

  @override
  Future<int> runInsert(
    QueryExecutor executor,
    String statement,
    List<Object?> args,
  ) {
    final accepted = _accept(statement, args);
    if (accepted) {
      _talker.logCustom(DriftQueryLog(statement, args: args, settings: settings));
    }
    return _run<int>(
      statement,
      () => executor.runInsert(statement, args),
      onDone: (ms) {
        if (accepted) {
          // Using affected to store inserted row id (for visibility)
          _talker.logCustom(
            DriftResultLog(statement, settings: settings, durationMs: ms),
          );
        }
      },
      onError: (err, ms) {
        if (accepted && _acceptError(err)) {
          _talker.logCustom(
            DriftErrorLog(statement, settings: settings, dbError: err, args: args, durationMs: ms),
          );
        }
      },
    );
  }

  @override
  Future<int> runUpdate(
    QueryExecutor executor,
    String statement,
    List<Object?> args,
  ) {
    final accepted = _accept(statement, args);
    if (accepted) {
      _talker.logCustom(DriftQueryLog(statement, args: args, settings: settings));
    }
    return _run<int>(
      statement,
      () => executor.runUpdate(statement, args),
      onDone: (ms) => accepted
          ? _talker.logCustom(
              DriftResultLog(
                statement,
                settings: settings,
                durationMs: ms,
              ),
            )
          : null,
      onError: (err, ms) {
        if (accepted && _acceptError(err)) {
          _talker.logCustom(
            DriftErrorLog(statement, settings: settings, dbError: err, args: args, durationMs: ms),
          );
        }
      },
    );
  }

  @override
  Future<int> runDelete(
    QueryExecutor executor,
    String statement,
    List<Object?> args,
  ) {
    final accepted = _accept(statement, args);
    if (accepted) {
      _talker.logCustom(DriftQueryLog(statement, args: args, settings: settings));
    }
    return _run<int>(
      statement,
      () => executor.runDelete(statement, args),
      onDone: (ms) => accepted
          ? _talker.logCustom(
              DriftResultLog(
                statement,
                settings: settings,
                durationMs: ms,
              ),
            )
          : null,
      onError: (err, ms) {
        if (accepted && _acceptError(err)) {
          _talker.logCustom(
            DriftErrorLog(statement, settings: settings, dbError: err, args: args, durationMs: ms),
          );
        }
      },
    );
  }

  @override
  Future<void> runCustom(
    QueryExecutor executor,
    String statement,
    List<Object?> args,
  ) {
    final accepted = _accept(statement, args);
    if (accepted) {
      _talker.logCustom(DriftQueryLog(statement, args: args, settings: settings));
    }
    return _run<void>(
      statement,
      () => executor.runCustom(statement, args),
      onDone: (ms) => accepted
          ? _talker.logCustom(
              DriftResultLog(
                statement,
                settings: settings,
                durationMs: ms,
              ),
            )
          : null,
      onError: (err, ms) {
        if (accepted && _acceptError(err)) {
          _talker.logCustom(
            DriftErrorLog(statement, settings: settings, dbError: err, args: args, durationMs: ms),
          );
        }
      },
    );
  }

  @override
  Future<List<Map<String, Object?>>> runSelect(
    QueryExecutor executor,
    String statement,
    List<Object?> args,
  ) async {
    final accepted = _accept(statement, args);
    if (accepted) {
      _talker.logCustom(DriftQueryLog(statement, args: args, settings: settings));
    }
    final sw = Stopwatch()..start();
    try {
      final rows = await executor.runSelect(statement, args);
      sw.stop();
      if (accepted) {
        _talker.logCustom(
          DriftResultLog(
            statement,
            settings: settings,
            durationMs: sw.elapsedMilliseconds,
            rowCount: rows.length,
            rows: rows,
          ),
        );
      }
      return rows;
    } catch (err) {
      sw.stop();
      if (accepted && _acceptError(err)) {
        _talker.logCustom(
          DriftErrorLog(
            statement,
            settings: settings,
            dbError: err,
            args: args,
            durationMs: sw.elapsedMilliseconds,
          ),
        );
      }
      rethrow;
    }
  }
}
