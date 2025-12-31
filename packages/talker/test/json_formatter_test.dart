import 'package:talker/talker.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerJsonFormatter', () {
    group('default formatter', () {
      test('formats simple object with indentation', () {
        const formatter = TalkerJsonFormatter();
        final result = formatter.format({'name': 'John', 'age': 30});

        expect(result, contains('"name": "John"'));
        expect(result, contains('"age": 30'));
        expect(result, contains('\n')); // Has indentation
      });

      test('formats nested object', () {
        const formatter = TalkerJsonFormatter();
        final result = formatter.format({
          'user': {'name': 'John', 'age': 30}
        });

        expect(result, contains('"user"'));
        expect(result, contains('"name": "John"'));
      });

      test('formats list', () {
        const formatter = TalkerJsonFormatter();
        final result = formatter.format([1, 2, 3]);

        expect(result, contains('1'));
        expect(result, contains('2'));
        expect(result, contains('3'));
      });
    });

    group('stripQuotes', () {
      test('strips quotes from keys and string values', () {
        const formatter = TalkerJsonFormatter(stripQuotes: true);
        final result = formatter.format({'name': 'John', 'age': 30});

        expect(result, contains('name: John'));
        expect(result, contains('age: 30'));
        expect(result, isNot(contains('"name"')));
        expect(result, isNot(contains('"John"')));
      });

      test('preserves escaped quotes in values', () {
        const formatter = TalkerJsonFormatter(stripQuotes: true);
        final result = formatter.format({'name': 'John "Doe"'});

        expect(result, contains('name: John "Doe"'));
      });

      test('handles nested objects with escaped quotes', () {
        const formatter = TalkerJsonFormatter(stripQuotes: true);
        final result = formatter.format({
          'user': {'name': 'John "The Man" Doe', 'title': 'Mr.'}
        });

        expect(result, contains('name: John "The Man" Doe'));
        expect(result, contains('title: Mr.'));
      });

      test('strips quotes from array elements', () {
        const formatter = TalkerJsonFormatter(stripQuotes: true);
        final result = formatter.format(['hello', 'world']);

        expect(result, isNot(contains('"hello"')));
        expect(result, isNot(contains('"world"')));
      });
    });

    group('custom formatter', () {
      test('uses custom formatter function', () {
        final formatter = TalkerJsonFormatter.custom((data) => 'CUSTOM: $data');
        final result = formatter.format({'key': 'value'});

        expect(result, equals('CUSTOM: {key: value}'));
      });

      test('custom formatter receives original data', () {
        dynamic receivedData;
        final formatter = TalkerJsonFormatter.custom((data) {
          receivedData = data;
          return 'processed';
        });

        final inputData = {'key': 'value'};
        formatter.format(inputData);

        expect(receivedData, equals(inputData));
      });

      test('custom formatter ignores stripQuotes', () {
        // stripQuotes is set to false when using custom constructor
        final formatter = TalkerJsonFormatter.custom((data) => 'CUSTOM: $data');

        expect(formatter.stripQuotes, isFalse);
      });
    });

    group('edge cases', () {
      test('handles null value in map', () {
        const formatter = TalkerJsonFormatter();
        final result = formatter.format({'key': null});

        expect(result, contains('null'));
      });

      test('handles empty map', () {
        const formatter = TalkerJsonFormatter();
        final result = formatter.format({});

        expect(result, equals('{}'));
      });

      test('handles empty list', () {
        const formatter = TalkerJsonFormatter();
        final result = formatter.format([]);

        expect(result, equals('[]'));
      });

      test('handles boolean values', () {
        const formatter = TalkerJsonFormatter(stripQuotes: true);
        final result = formatter.format({'active': true, 'deleted': false});

        expect(result, contains('active: true'));
        expect(result, contains('deleted: false'));
      });

      test('handles numeric values', () {
        const formatter = TalkerJsonFormatter(stripQuotes: true);
        final result = formatter.format({'int': 42, 'double': 3.14});

        expect(result, contains('int: 42'));
        expect(result, contains('double: 3.14'));
      });
    });
  });
}
