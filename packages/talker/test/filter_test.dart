import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerFilter', () {
    _testFilterByKeys(useTalkerFilter: false);
    _testFilterByKeys(useTalkerFilter: true);

    _testFilterBySearchText(useTalkerFilter: false);
    _testFilterBySearchText(useTalkerFilter: true);
  });

  _testSimpleFilter();
  _testCombineFilter();
}

TalkerData _log(String key, [String msg = 'msg']) => TalkerLog(msg, key: key);

void _testSimpleFilter() {
  group('TalkerFilter.simple', () {
    final filter = TalkerFilter.simple((item) => item.key == 'error');

    test('passes item when condition returns true', () {
      expect(filter.filter(_log('error')), isTrue);
    });

    test('rejects item when condition returns false', () {
      expect(filter.filter(_log('info')), isFalse);
    });

    test('applies key and search fields together with condition', () {
      final withKeys = SimpleTalkerFilter(
        (item) => item.key == 'error',
        disabledKeys: ['error'],
      );
      final withSearch = SimpleTalkerFilter(
        (item) => item.key == 'error',
        searchQuery: 'ok',
      );

      expect(withKeys.filter(_log('error')), isFalse);
      expect(withSearch.filter(_log('error', 'ok')), isTrue);
      expect(withSearch.filter(_log('error', 'nope')), isFalse);
    });

    test('copyWith keeps custom condition and type', () {
      final copy = filter.copyWith(disabledKeys: ['verbose']);

      expect(copy, isA<SimpleTalkerFilter>());
      expect(copy.disabledKeys, ['verbose']);
      expect(copy.filter(_log('error')), isTrue);
      expect(copy.filter(_log('info')), isFalse);
    });

    test('works as Talker filter', () {
      final talker = Talker(
        filter: TalkerFilter.simple((item) => item.key == 'error'),
      );

      talker.error('shown');
      talker.info('hidden');

      expect(talker.history.length, 1);
      expect(talker.history.single.key, 'error');
    });
  });
}

void _testCombineFilter() {
  group('TalkerFilter.combine', () {
    final filter = TalkerFilter.combine([
      TalkerFilter.simple((item) => item.key == 'error'),
      TalkerFilter.simple((item) => item.generateTextMessage().contains('ok')),
    ]);

    test('passes item only when all filters pass', () {
      expect(filter.filter(_log('error', 'ok')), isTrue);
    });

    test('rejects item when any filter rejects', () {
      expect(filter.filter(_log('error', 'nope')), isFalse);
      expect(filter.filter(_log('info', 'ok')), isFalse);
    });

    test('passes everything for an empty list', () {
      expect(TalkerFilter.combine([]).filter(_log('error')), isTrue);
    });

    test('applies key and search fields together with filters', () {
      final withKeys = MultiTalkerFilter(
        [TalkerFilter.simple((item) => true)],
        disabledKeys: ['info'],
      );

      expect(withKeys.filter(_log('info')), isFalse);
      expect(withKeys.filter(_log('error')), isTrue);
    });

    test('copyWith keeps combined filters and type', () {
      final copy = filter.copyWith(searchQuery: 'ok');

      expect(copy, isA<MultiTalkerFilter>());
      expect(copy.searchQuery, 'ok');
      expect(copy.filter(_log('error', 'ok')), isTrue);
      expect(copy.filter(_log('info', 'ok')), isFalse);
    });

    test('works as Talker filter', () {
      final talker = Talker(
        filter: TalkerFilter.combine([
          TalkerFilter(disabledKeys: ['verbose']),
          TalkerFilter.simple((item) => item.key != 'debug'),
        ]),
      );

      talker.info('shown');
      talker.verbose('hidden by keys');
      talker.debug('hidden by simple');

      expect(talker.history.length, 1);
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

void _testFilterByKeys({
  required bool useTalkerFilter,
}) {
  return group(
    'By title',
    () {
      _testFilterFoundByKey(
        useTalkerFilter: useTalkerFilter,
        keys: ['error'],
        countFound: 1,
        logCallback: (talker) {
          talker.error('Test log');
        },
      );

      _testFilterFoundByKey(
        useTalkerFilter: useTalkerFilter,
        keys: ['error', 'exception'],
        countFound: 2,
        logCallback: (talker) {
          talker.error('Test log');
          talker.handle(Exception('Test log'));
        },
      );

      _testFilterFoundByKey(
        useTalkerFilter: useTalkerFilter,
        keys: ['error', 'verbose'],
        countFound: 2,
        logCallback: (talker) {
          talker.error('Test log');
          talker.handle(Exception('Test disabled log'));
          talker.verbose('Test log');
        },
      );

      _testFilterFoundByKey(
        useTalkerFilter: useTalkerFilter,
        keys: ['verbose'],
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
  final filter = TalkerFilter(enabledKeys: [], searchQuery: searchQuery);

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

void _testFilterFoundByKey(
    {required List<String> keys,
    required Function(Talker) logCallback,
    required int countFound,
    required bool useTalkerFilter}) {
  final filter = TalkerFilter(enabledKeys: keys);
  final talker = useTalkerFilter ? Talker(filter: filter) : Talker();

  test(
      'Found $countFound ${useTalkerFilter ? 'By Talker' : 'By Filter'} in ${keys.join(',')}',
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
      final filter = TalkerFilter(enabledKeys: [matchingKey]);

      final item = createData(matchingKey, 'Log message');

      expect(filter.filter(item), isTrue);
    });

    test('should reject item with non-matching key', () {
      final filter = TalkerFilter(enabledKeys: [matchingKey]);

      final item = createData(nonMatchingKey, 'Another log');

      expect(filter.filter(item), isFalse);
    });

    test('should allow item with matching key and matching search query', () {
      final filter = TalkerFilter(
        enabledKeys: [matchingKey],
        searchQuery: 'important',
      );

      final item = createData(matchingKey, 'Important log happened');

      expect(filter.filter(item), isTrue);
    });

    test('should reject item with matching key but not matching search query',
        () {
      final filter = TalkerFilter(
        enabledKeys: [matchingKey],
        searchQuery: 'missing',
      );

      final item = createData(matchingKey, 'Some other log');

      expect(filter.filter(item), isFalse);
    });

    test('should ignore key filtering if keys list is empty', () {
      final filter = TalkerFilter(enabledKeys: []);

      final item = createData(nonMatchingKey, 'Anything goes');

      // Falls back to deprecated _oldFilterLogic, which might return true or false depending on other fields.
      // But since all deprecated fields are empty here, the logic returns true.
      expect(filter.filter(item), isTrue);
    });
  });
}
