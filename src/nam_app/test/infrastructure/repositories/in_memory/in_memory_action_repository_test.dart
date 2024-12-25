import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/action.dart';
import 'package:nam_app/infrastructure/repositories/in_memory/in_memory_action_repository.dart';

void main() {
  group('InMemoryActionRepository', () {
    late InMemoryActionRepository repository;

    setUp(() {
      repository = InMemoryActionRepository();
    });

    test('add() should store an action', () async {
      final action = NamAction(id: '1', title: 'Test Action');

      await repository.add(action);
      final result = await repository.getAll();

      expect(result, contains(action));
    });

    test('getById() should retrieve the correct action', () async {
      final action = NamAction(id: '1', title: 'Test Action');
      await repository.add(action);

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result?.id, equals('1'));
      expect(result?.title, equals('Test Action'));
    });

    test('delete() should remove the action by id', () async {
      final action = NamAction(id: '1', title: 'Test Action');
      await repository.add(action);

      await repository.delete('1');
      final result = await repository.getById('1');

      expect(result, isNull);
    });

    test('getAll() should return all stored actions', () async {
      final action1 = NamAction(id: '1', title: 'Action 1');
      final action2 = NamAction(id: '2', title: 'Action 2');

      await repository.add(action1);
      await repository.add(action2);

      final result = await repository.getAll();

      expect(result.length, equals(2));
      expect(result, containsAll([action1, action2]));
    });

    test('update() should modify an existing action', () async {
      final action = NamAction(id: '1', title: 'Initial Title');
      await repository.add(action);

      final updatedAction = NamAction(id: '1', title: 'Updated Title');
      await repository.update(updatedAction);

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result?.title, equals('Updated Title'));
    });

    test('add() should throw an exception for duplicate IDs', () async {
      final action1 = NamAction(id: '1', title: 'Action 1');
      final action2 = NamAction(id: '1', title: 'Duplicate Action');

      await repository.add(action1);

      expect(
        () async => await repository.add(action2),
        throwsA(isA<ArgumentError>()),
      );

      final result = await repository.getAll();
      expect(result.length, equals(1));
      expect(result.first.title, equals('Action 1'));
    });

    test('delete() should throw an exception if the id does not exist',
        () async {
      expect(
        () async => await repository.delete('non-existent-id'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('update() should throw an exception if the action does not exist',
        () async {
      final updatedAction =
          NamAction(id: 'non-existent-id', title: 'Updated Title');

      expect(
        () async => await repository.update(updatedAction),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('getById() should return null for non-existent id', () async {
      final result = await repository.getById('non-existent-id');

      expect(result, isNull);
    });

    test('getAll() should return an unmodifiable list', () async {
      final action = NamAction(id: '1', title: 'Test Action');
      await repository.add(action);

      final result = await repository.getAll();

      expect(() => result.add(action), throwsUnsupportedError);
    });
  });
}
