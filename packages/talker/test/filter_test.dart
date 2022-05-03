import 'package:talker/talker.dart';
import 'package:test/test.dart';

final talker = Talker();

void main() {
  setUp(() {
    talker.cleanHistory();
  });

  group('Talker_Filter', () {
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
