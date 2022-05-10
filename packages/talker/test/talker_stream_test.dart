import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerStream', () {
    final talker = Talker();

    test('handle', () async {
      talker.error('Test message');
      talker.stream
          .listen((log) => expectAsync1((event) => event is TalkerLog));
    });
  });
}
