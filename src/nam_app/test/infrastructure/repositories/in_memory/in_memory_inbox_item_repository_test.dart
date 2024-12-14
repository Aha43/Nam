import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/inbox_item.dart';
import 'package:nam_app/infrastructure/repositories/in_memory/in_memory_inbox_item_repository.dart';

void main() {
  group('InMemoryInboxItemRepository Tests', () {
    late InMemoryInboxItemRepository repository;

    setUp(() {
      repository = InMemoryInboxItemRepository();
    });

    test('should add and retrieve an InboxItem', () async {
      final item = InboxItem(id: '1', content: 'Test content');
      await repository.add(item);

      final allItems = await repository.getAll();
      expect(allItems, contains(item));

      final retrievedItem = await repository.getById('1');
      expect(retrievedItem, isNotNull);
      expect(retrievedItem?.id, '1');
      expect(retrievedItem?.content, 'Test content');
    });

    test('should throw an exception when adding a duplicate InboxItem', () async {
      final item = InboxItem(id: '1', content: 'Test content');
      await repository.add(item);

      expect(() async => await repository.add(item),
          throwsA(isA<Exception>()));
    });

    test('should update an existing InboxItem', () async {
      final item = InboxItem(id: '1', content: 'Original content');
      await repository.add(item);

      final updatedItem = InboxItem(id: '1', content: 'Updated content');
      await repository.update(updatedItem);

      final retrievedItem = await repository.getById('1');
      expect(retrievedItem?.content, 'Updated content');
    });

    test('should throw an exception when updating a non-existent InboxItem', () async {
      final item = InboxItem(id: '1', content: 'Non-existent item');
      expect(() async => await repository.update(item),
          throwsA(isA<Exception>()));
    });

    test('should delete an existing InboxItem', () async {
      final item = InboxItem(id: '1', content: 'Test content');
      await repository.add(item);

      await repository.delete('1');

      final retrievedItem = await repository.getById('1');
      expect(retrievedItem, isNull);
    });

    test('should do nothing when deleting a non-existent InboxItem', () async {
      await repository.delete('non-existent');
      final allItems = await repository.getAll();
      expect(allItems, isEmpty);
    });
  });
}
