import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:talker/talker.dart';
import 'package:talker_drift_logger/talker_drift_logger.dart';

// Run: dart run bin/main.dart
Future<void> main() async {
  final talker = Talker();

  final executor = NativeDatabase.memory().interceptWith(
    TalkerDriftLogger(
      talker: talker,
      settings: const TalkerDriftLoggerSettings(
        printArgs: true,
        printResults: true,
      ),
    ),
  );

  final db = _DummyDb(executor);

  await db.customStatement(
      'CREATE TABLE users (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT);');
  await db.customStatement("INSERT INTO users (name) VALUES ('Alice')");
  await db.customStatement("INSERT INTO users (name) VALUES ('Bob')");

  final rows = await db.customSelect('SELECT * FROM users').get();
  talker.info('Selected ${rows.length} users');
}

class _DummyDb extends GeneratedDatabase {
  _DummyDb(QueryExecutor e) : super(e);
  @override
  int get schemaVersion => 1;
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => const [];
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => const [];
}
