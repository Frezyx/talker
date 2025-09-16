import 'dart:async';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:talker/talker.dart';
import 'package:test/test.dart';
import 'package:talker_drift_logger/talker_drift_logger.dart';

// Minimal database to open the executor properly
class _DummyDb extends GeneratedDatabase {
  _DummyDb(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  Iterable<TableInfo<Table, Object?>> get allTables => const [];

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => const [];
}

void main() {
  group('TalkerDriftLogger', () {
    test('logs query and result for SELECT', () async {
      final talker = Talker();
      final logs = <TalkerData>[];
      final sub = talker.stream.listen(logs.add);

      final executor = NativeDatabase.memory()
          .interceptWith(TalkerDriftLogger(talker: talker));
      final db = _DummyDb(executor);

      // schema
      await db.customStatement(
          'CREATE TABLE users (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT);');

      // insert
      await db.customStatement("INSERT INTO users (name) VALUES ('Alice')");

      // select
      final rows = await db.customSelect('SELECT * FROM users').get();
      expect(rows, isNotEmpty);

      // Allow stream to emit
      await Future<void>.delayed(const Duration(milliseconds: 5));

      // There must be at least one query and one result log
      final hasQuery = logs.whereType<TalkerLog>().any((e) => e.key == 'drift-query');
      final hasResult = logs.whereType<TalkerLog>().any((e) => e.key == 'drift-result');
      expect(hasQuery, isTrue);
      expect(hasResult, isTrue);

      await sub.cancel();
    });

    test('logs error on invalid select', () async {
      final talker = Talker();
      final logs = <TalkerData>[];
      final sub = talker.stream.listen(logs.add);
      final executor = NativeDatabase.memory()
          .interceptWith(TalkerDriftLogger(talker: talker));
      final db = _DummyDb(executor);

      try {
        await db.customSelect('SELECT * FROM missing_table').get();
        fail('Expected an error');
      } catch (_) {
        // expected
      }

      // Allow stream to emit
      await Future<void>.delayed(const Duration(milliseconds: 5));

      final hasError = logs.whereType<TalkerLog>().any((e) => e.key == 'drift-error');
      expect(hasError, isTrue);

      await sub.cancel();
    });
  });
}
