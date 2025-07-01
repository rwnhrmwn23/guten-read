import 'package:flutter_test/flutter_test.dart';
import 'package:gutenread/data/model/book_model.dart';

void main() {
  group('BookModel.toEntity()', () {
    test('should convert complete data correctly', () {
      final model = BookModel(
        id: 1,
        title: 'Test Book',
        authors: [Author(name: 'John Doe', birthYear: 1970, deathYear: 2020)],
        summaries: ['This is a summary.'],
        formats: {
          'image/jpeg': 'http://image.com/book.jpg',
          'text/html': 'http://text.com/book.html',
        },
        downloadCount: 999,
      );

      final entity = model.toEntity();

      expect(entity.id, 1);
      expect(entity.title, 'Test Book');
      expect(entity.summary, 'This is a summary.');
      expect(entity.imageUrl, 'http://image.com/book.jpg');
      expect(entity.textUrl, 'http://text.com/book.html');
      expect(entity.author, 'John Doe');
      expect(entity.birthYear, '1970');
      expect(entity.deathYear, '2020');
      expect(entity.downloadCount, 999);
    });

    test('should fallback to defaults when authors, summaries, and formats are empty', () {
      final model = BookModel(
        id: 2,
        title: 'No Author Book',
        authors: [],
        summaries: [],
        formats: {},
        downloadCount: 0,
      );

      final entity = model.toEntity();

      expect(entity.author, 'Unknown');
      expect(entity.birthYear, 'Unknown');
      expect(entity.deathYear, 'Unknown');
      expect(entity.summary, 'No overview available');
      expect(entity.imageUrl, '');
      expect(entity.textUrl, '');
    });

    test('should convert null birthYear and deathYear to string "null"', () {
      final model = BookModel(
        id: 3,
        title: 'Partial Author Info',
        authors: [Author(name: 'Jane Doe', birthYear: null, deathYear: null)],
        summaries: ['Some summary.'],
        formats: {
          'image/jpeg': 'http://image.com/partial.jpg',
          'text/html': 'http://text.com/partial.html',
        },
        downloadCount: 123,
      );

      final entity = model.toEntity();

      expect(entity.author, 'Jane Doe');
      expect(entity.birthYear, 'null');
      expect(entity.deathYear, 'null');
    });
  });
}
