import 'package:talker/talker.dart';
import 'package:test/test.dart';

final _errHandler = TalkerErrorHandler(TalkerSettings());

class TestException implements Exception {}

class FakeTestException {}

void main() {
  group('Talker_ErrorHandler', () {
    group('handle Error', () {
      _testHandleError(ArgumentError());
      _testHandleError(RangeError('a'));
      _testHandleError(AssertionError());
    });

    group('handle Exception', () {
      _testHandleException(Exception());
      _testHandleException(const FormatException());
      _testHandleException(TestException());
    });

    group('handle something else', () {
      _testHandleSomething(Object());
      _testHandleSomething('FFFFF');
      _testHandleSomething(FakeTestException());
    });
  });
}

void _testHandleError(Object err) {
  test('$err', () {
    final data = _errHandler.handle(err);

    expect(data, isNotNull);
    expect(data, isA<TalkerError>());
  });
}

void _testHandleException(Object exception) {
  test('$exception', () {
    final data = _errHandler.handle(exception);

    expect(data, isNotNull);
    expect(data, isA<TalkerException>());
  });
}

void _testHandleSomething(Object something) {
  test('$something', () {
    final data = _errHandler.handle(something);

    expect(data, isNotNull);
    expect(data, isA<TalkerLog>());
  });
}
