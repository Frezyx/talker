import 'package:talker/talker.dart';
import 'package:test/test.dart';

final talker = Talker();

void main() {
  setUp(() {
    talker.cleanHistory();
  });

  group('TalkerFilter', () {
    group(
      'By title',
      () {
        _testFilterFoundByTitle(
          titles: ['ERROR'],
          countFound: 1,
          logCallback: () {
            talker.error('Test log');
          },
        );

        _testFilterFoundByTitle(
          titles: ['ERROR', 'EXCEPTION'],
          countFound: 2,
          logCallback: () {
            talker.error('Test log');
            talker.handleException(Exception('Test log'));
          },
        );

        _testFilterFoundByTitle(
          titles: ['ERROR', 'VERBOSE'],
          countFound: 2,
          logCallback: () {
            talker.error('Test log');
            talker.handleException(Exception('Test disabled log'));
            talker.verbose('Test log');
          },
        );

        _testFilterFoundByTitle(
          titles: ['VERBOSE'],
          countFound: 5,
          logCallback: () {
            talker.verbose('Test log');
            talker.verbose('Test log');
            talker.error('Test log');
            talker.verbose('Test log');
            talker.verbose('Test log');
            talker.handleException(Exception('Test disabled log'));
            talker.verbose('Test log');
          },
        );
      },
    );

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

void _testFilterFoundByTitle({
  required List<String> titles,
  required Function() logCallback,
  required int countFound,
}) {
  final filter = TalkerFilter(types: [], titles: titles);
  test('Found $countFound in ${titles.join(',')}', () {
    logCallback.call();
    final foundRecords = talker.history.where((e) => filter.filter(e)).toList();
    expect(foundRecords, isNotEmpty);
    expect(foundRecords.length, countFound);
  });
}
