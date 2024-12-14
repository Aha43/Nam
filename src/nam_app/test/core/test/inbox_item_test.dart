import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/inbox_item.dart';

void main() {
  group('InboxItem Entity Tests', () {
    test('should create an InboxItem with default values', () {
      final item = InboxItem(id: '1', content: 'Test content');

      expect(item.id, '1');
      expect(item.content, 'Test content');
      expect(item.createdAt.isBefore(DateTime.now()), isTrue);
      expect(item.actionId, isNull);
      expect(item.projectId, isNull);
      expect(item.isProcessed(), isFalse);
    });

    test('should create an InboxItem with custom values', () {
      final now = DateTime.now();
      final item = InboxItem(
        id: '2',
        content: 'Custom content',
        createdAt: now,
        actionId: 'action1',
        projectId: 'project1',
      );

      expect(item.id, '2');
      expect(item.content, 'Custom content');
      expect(item.createdAt, now);
      expect(item.actionId, 'action1');
      expect(item.projectId, 'project1');
      expect(item.isProcessed(), isTrue);
    });

    test('toString should return the correct format', () {
      final item = InboxItem(
        id: '3',
        content: 'Stringify content',
        actionId: 'action1',
        projectId: 'project1',
      );

      expect(
        item.toString(),
        'InboxItem(id: 3, content: Stringify content, createdAt: ${item.createdAt}, '
        'actionId: action1, projectId: project1)',
      );
    });
  });
}
