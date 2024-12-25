import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/inbox_item.dart';

void main() {
  group('InboxItem Entity Tests', () {
    test('should create an InboxItem with default values', () {
      final item = InboxItem(id: '1', content: 'Test content');

      expect(item.id, '1');
      expect(item.content, 'Test content');
      expect(item.createdAt.isBefore(DateTime.now()), isTrue);
    });

    test('should create an InboxItem with custom values', () {
      final now = DateTime.now();
      final item = InboxItem(
        id: '2',
        content: 'Custom content',
        createdAt: now,
      );

      expect(item.id, '2');
      expect(item.content, 'Custom content');
      expect(item.createdAt, now);
    });

    test('toString should return the correct format', () {
      final item = InboxItem(
        id: '3',
        content: 'Stringify content',
      );

      expect(
        item.toString(),
        'InboxItem(id: 3, content: Stringify content, createdAt: ${item.createdAt})'
      );
    });
  });
}
