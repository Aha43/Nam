// test/infrastructure/repositories/in_memory_context_repository_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/context.dart';
import 'package:nam_app/infrastructure/repositories/in_memory/in_memory_context_repository.dart';

void main() {
  group('InMemoryContextRepository', () {
    late InMemoryContextRepository repository;

    setUp(() {
      repository = InMemoryContextRepository();
    });

    test('add() should store a context', () async {
      final context = Context(id: '1', name: 'Test Context');

      await repository.add(context);
      final result = await repository.getAll();

      expect(result, contains(context));
    });

    test('getById() should retrieve the correct context', () async {
      final context = Context(id: '1', name: 'Test Context');
      await repository.add(context);

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result?.id, equals('1'));
      expect(result?.name, equals('Test Context'));
    });

    test('delete() should remove the context by id', () async {
      final context = Context(id: '1', name: 'Test Context');
      await repository.add(context);

      await repository.delete('1');
      final result = await repository.getById('1');

      expect(result, isNull);
    });

    test('getAll() should return all stored contexts', () async {
      final context1 = Context(id: '1', name: 'Context 1');
      final context2 = Context(id: '2', name: 'Context 2');

      await repository.add(context1);
      await repository.add(context2);

      final result = await repository.getAll();

      expect(result.length, equals(2));
      expect(result, containsAll([context1, context2]));
    });

    test('update() should modify an existing context', () async {
      final context = Context(id: '1', name: 'Initial Name');
      await repository.add(context);

      final updatedContext = Context(id: '1', name: 'Updated Name');
      await repository.update(updatedContext);

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result?.name, equals('Updated Name'));
    });
  });
}
