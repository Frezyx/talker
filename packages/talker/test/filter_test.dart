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
            talker.error('Test disabled log');
          },
        );

        _testFilterFoundByTitle(
          titles: ['ERROR', 'EXCEPTION'],
          countFound: 2,
          logCallback: () {
            talker.error('Test disabled log');
            talker.handleException(Exception('Test disabled log'));
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
