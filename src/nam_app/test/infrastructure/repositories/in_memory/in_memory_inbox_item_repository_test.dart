import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/inbox_item.dart';
import 'package:nam_app/infrastructure/repositories/in_memory/in_memory_inbox_item_repository.dart';

void main() {
  group('InMemoryInboxItemRepository', () {
    late InMemoryInboxItemRepository repository;

    setUp(() {
      repository = InMemoryInboxItemRepository();
    });

    test('add() should store an inbox item', () async {
      final inboxItem = InboxItem(id: '1', content: 'Test Item');

      await repository.add(inboxItem);
      final result = await repository.getAll();

      expect(result, contains(inboxItem));
    });

    test('getById() should retrieve the correct inbox item', () async {
      final inboxItem = InboxItem(id: '1', content: 'Test Item');
      await repository.add(inboxItem);

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result?.id, equals('1'));
      expect(result?.content, equals('Test Item'));
    });

    test('delete() should remove the inbox item by id', () async {
      final inboxItem = InboxItem(id: '1', content: 'Test Item');
      await repository.add(inboxItem);

      await repository.delete('1');
      final result = await repository.getById('1');

      expect(result, isNull);
    });

    test('getAll() should return all stored inbox items', () async {
      final item1 = InboxItem(id: '1', content: 'Item 1');
      final item2 = InboxItem(id: '2', content: 'Item 2');

      await repository.add(item1);
      await repository.add(item2);

      final result = await repository.getAll();

      expect(result.length, equals(2));
      expect(result, containsAll([item1, item2]));
    });

    test('update() should modify an existing inbox item', () async {
      final inboxItem = InboxItem(id: '1', content: 'Initial Title');
      await repository.add(inboxItem);

      final updatedInboxItem = InboxItem(id: '1', content: 'Updated Title');
      await repository.update(updatedInboxItem);

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result?.content, equals('Updated Title'));
    });

    test('add() should throw an exception for duplicate IDs', () async {
      final item1 = InboxItem(id: '1', content: 'Item 1');
      final item2 = InboxItem(id: '1', content: 'Duplicate Item');

      await repository.add(item1);

      expect(
        () async => await repository.add(item2),
        throwsA(isA<ArgumentError>()),
      );

      final result = await repository.getAll();
      expect(result.length, equals(1));
      expect(result.first.content, equals('Item 1'));
    });

    test('delete() should throw an exception if the id does not exist', () async {
      expect(
        () async => await repository.delete('non-existent-id'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('update() should throw an exception if the inbox item does not exist', () async {
      final updatedInboxItem = InboxItem(id: 'non-existent-id', content: 'Updated Title');

      expect(
        () async => await repository.update(updatedInboxItem),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('getById() should return null for non-existent id', () async {
      final result = await repository.getById('non-existent-id');

      expect(result, isNull);
    });

    test('getAll() should return an unmodifiable list', () async {
      final inboxItem = InboxItem(id: '1', content: 'Test Item');
      await repository.add(inboxItem);

      final result = await repository.getAll();

      expect(() => result.add(inboxItem), throwsUnsupportedError);
    });
  });
}
