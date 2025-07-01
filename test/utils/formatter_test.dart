import 'package:flutter_test/flutter_test.dart';
import 'package:gutenread/utils/formatter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gutenread/domain/entities/book.dart';

class MockBook extends Mock implements Book {}

void main() {
  group('formatNumber', () {
    test('should format number with thousands separator', () {
      const input = 1234567;
      const expected = '1,234,567';

      final result = formatNumber(input);

      expect(result, equals(expected));
    });

    test('should format small number without separator', () {
      const input = 123;
      const expected = '123';

      final result = formatNumber(input);

      expect(result, equals(expected));
    });

    test('should format zero correctly', () {
      const input = 0;
      const expected = '0';

      final result = formatNumber(input);

      expect(result, equals(expected));
    });

    test('should format negative number correctly', () {
      const input = -123456;
      const expected = '-123,456';

      final result = formatNumber(input);

      expect(result, equals(expected));
    });
  });

  group('authorAndYearInfo', () {
    late MockBook mockBook;

    setUp(() {
      mockBook = MockBook();
    });

    test('should return empty string when book is null', () {
      Book? book = null;

      final result = authorAndYearInfo(book);

      expect(result, equals(''));
    });

    test('should return author name only when birth and death years are null', () {
      when(() => mockBook.author).thenReturn('Jane Austen');
      when(() => mockBook.birthYear).thenReturn('null');
      when(() => mockBook.deathYear).thenReturn('null');

      final result = authorAndYearInfo(mockBook);

      expect(result, equals('Jane Austen'));
    });

    test('should return author with complete birth and death years', () {
      when(() => mockBook.author).thenReturn('Jane Austen');
      when(() => mockBook.birthYear).thenReturn('1775');
      when(() => mockBook.deathYear).thenReturn('1817');

      final result = authorAndYearInfo(mockBook);

      expect(result, equals('Jane Austen (1775 - 1817)'));
    });
  });
}