import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerFilter', () {
    _testFilterByTitles(useTalkerFilter: false);
    _testFilterByTitles(useTalkerFilter: true);

    _testFilterByTypes(useTalkerFilter: false);
    _testFilterByTypes(useTalkerFilter: true);

    _testFilterBySearchText(useTalkerFilter: false);
    _testFilterBySearchText(useTalkerFilter: true);

    test('copyWith', () {
      final filter = TalkerFilter(
        titles: ['Error'],
        types: [Exception],
      );
      final newFilter = filter.copyWith(titles: ['LOG']);
      expect(filter == newFilter, false);
      expect(filter.titles == newFilter.titles, false);
      expect(filter.titles.first == newFilter.titles.first, false);

      final typesChangesFilter = filter.copyWith(types: [Error]);
      expect(filter == typesChangesFilter, false);
      expect(filter.types == typesChangesFilter.types, false);
      expect(filter.types.first == typesChangesFilter.types.first, false);
    });
  });
}

void _testFilterBySearchText({
  required bool useTalkerFilter,
}) {
  return group('By search text', () {
    _testFilterFoundBySearchText(
      useTalkerFilter: useTalkerFilter,
      searchQuery: 'http',
      countFound: 4,
      logCallback: (talker) {
        talker.error('HTTP log');
        talker.info('Log http request');
        talker.warning('http');
        talker.debug('Log http');
        talker.verbose('htt request');
        talker.info('ttp request');
      },
    );
  });
}

void _testFilterByTypes({
  required bool useTalkerFilter,
}) {
  group('By type', () {
    _testFilterFoundByType(
      useTalkerFilter: useTalkerFilter,
      types: [TalkerLog],
      countFound: 1,
      logCallback: (talker) {
        talker.error('Test log');
      },
    );
    _testFilterFoundByType(
      useTalkerFilter: useTalkerFilter,
      types: [TalkerError],
      countFound: 2,
      logCallback: (talker) {
        talker.info('Test log');
        talker.handle(ArgumentError());
        talker.handle(ArgumentError());
      },
    );
  });
}

void _testFilterByTitles({
  required bool useTalkerFilter,
}) {
  return group(
    'By title',
    () {
      _testFilterFoundByTitle(
        useTalkerFilter: useTalkerFilter,
        titles: ['error'],
        countFound: 1,
        logCallback: (talker) {
          talker.error('Test log');
        },
      );

      _testFilterFoundByTitle(
        useTalkerFilter: useTalkerFilter,
        titles: ['error', 'exception'],
        countFound: 2,
        logCallback: (talker) {
          talker.error('Test log');
          talker.handle(Exception('Test log'));
        },
      );

      _testFilterFoundByTitle(
        useTalkerFilter: useTalkerFilter,
        titles: ['error', 'verbose'],
        countFound: 2,
        logCallback: (talker) {
          talker.error('Test log');
          talker.handle(Exception('Test disabled log'));
          talker.verbose('Test log');
        },
      );

      _testFilterFoundByTitle(
        useTalkerFilter: useTalkerFilter,
        titles: ['verbose'],
        countFound: 5,
        logCallback: (talker) {
          talker.verbose('Test log');
          talker.verbose('Test log');
          talker.error('Test log');
          talker.verbose('Test log');
          talker.verbose('Test log');
          talker.handle(Exception('Test disabled log'));
          talker.handle(ArgumentError());
          talker.verbose('Test log');
          talker.critical('Test log');
        },
      );
    },
  );
}

void _testFilterFoundBySearchText({
  required String searchQuery,
  required Function(Talker talker) logCallback,
  required int countFound,
  required bool useTalkerFilter,
}) {
  final filter = TalkerFilter(types: [], titles: [], searchQuery: searchQuery);

  final talker = useTalkerFilter ? Talker(filter: filter) : Talker();

  test(
      'Found $countFound ${useTalkerFilter ? 'By Talker' : 'By Filter'} with searchQuery $searchQuery',
      () {
    logCallback.call(talker);
    final foundRecords = useTalkerFilter
        ? talker.history
        : talker.history.where((e) => filter.filter(e)).toList();

    expect(foundRecords.length, countFound);
  });
}

void _testFilterFoundByType({
  required List<Type> types,
  required Function(Talker talker) logCallback,
  required int countFound,
  required bool useTalkerFilter,
}) {
  final filter = TalkerFilter(types: types);
  final talker = useTalkerFilter ? Talker(filter: filter) : Talker();

  test(
      'Found $countFound ${useTalkerFilter ? 'By Talker' : 'By Filter'} in ${types.join(',')}',
      () {
    logCallback.call(talker);
    final foundRecords = useTalkerFilter
        ? talker.history
        : talker.history.where((e) => filter.filter(e)).toList();
    expect(foundRecords, isNotEmpty);
    expect(foundRecords.length, countFound);
  });
}

void _testFilterFoundByTitle(
    {required List<String> titles,
    required Function(Talker) logCallback,
    required int countFound,
    required bool useTalkerFilter}) {
  final filter = TalkerFilter(titles: titles);
  final talker = useTalkerFilter ? Talker(filter: filter) : Talker();

  test(
      'Found $countFound ${useTalkerFilter ? 'By Talker' : 'By Filter'} in ${titles.join(',')}',
      () {
    logCallback.call(talker);

    final foundRecords = useTalkerFilter
        ? talker.history
        : talker.history.where((e) => filter.filter(e)).toList();

    expect(foundRecords, isNotEmpty);
    expect(foundRecords.length, countFound);
  });

  group('BaseTalkerFilter - keys filtering', () {
    final matchingKey = 'test_key';
    final nonMatchingKey = 'other_key';

    TalkerData createData(String key, String msg) {
      return TalkerLog(msg, key: key);
    }

    test('should allow item with matching key', () {
      final filter = TalkerFilter(keys: [matchingKey]);

      final item = createData(matchingKey, 'Log message');

      expect(filter.filter(item), isTrue);
    });

    test('should reject item with non-matching key', () {
      final filter = TalkerFilter(keys: [matchingKey]);

      final item = createData(nonMatchingKey, 'Another log');

      expect(filter.filter(item), isFalse);
    });

    test('should allow item with matching key and matching search query', () {
      final filter = TalkerFilter(
        keys: [matchingKey],
        searchQuery: 'important',
      );

      final item = createData(matchingKey, 'Important log happened');

      expect(filter.filter(item), isTrue);
    });

    test('should reject item with matching key but not matching search query',
        () {
      final filter = TalkerFilter(
        keys: [matchingKey],
        searchQuery: 'missing',
      );

      final item = createData(matchingKey, 'Some other log');

      expect(filter.filter(item), isFalse);
    });

    test('should ignore key filtering if keys list is empty', () {
      final filter = TalkerFilter(keys: []);

      final item = createData(nonMatchingKey, 'Anything goes');

      // Falls back to deprecated _oldFilterLogic, which might return true or false depending on other fields.
      // But since all deprecated fields are empty here, the logic returns true.
      expect(filter.filter(item), isTrue);
    });
  });
}
