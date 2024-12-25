// test/infrastructure/repositories/in_memory_context_repository_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/action.dart';
import 'package:nam_app/core/entities/context.dart';
import 'package:nam_app/infrastructure/repositories/in_memory/in_memory_context_repository.dart';

void main() {
  group('InMemoryContextRepository', () {
    late InMemoryContextRepository repository;

    setUp(() {
      repository = InMemoryContextRepository();
    });

    test('add() should store a context', () async {
      final context = Context(
        id: '1',
        name: 'Test Context',
        ruleFunction: atLeastOneTag,
      );

      await repository.add(context);
      final result = await repository.getAll();

      expect(result, contains(context));
    });

    test('getById() should retrieve the correct context', () async {
      final context = Context(
        id: '1',
        name: 'Test Context',
        ruleFunction: atLeastOneTag,
      );
      await repository.add(context);

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result?.id, equals('1'));
      expect(result?.name, equals('Test Context'));
    });

    test('delete() should remove the context by id', () async {
      final context = Context(
        id: '1',
        name: 'Test Context',
        ruleFunction: atLeastOneTag,
      );
      await repository.add(context);

      await repository.delete('1');
      final result = await repository.getById('1');

      expect(result, isNull);
    });

    test('getAll() should return all stored contexts', () async {
      final context1 = Context(
        id: '1',
        name: 'Context 1',
        ruleFunction: atLeastOneTag,
      );
      final context2 = Context(
        id: '2',
        name: 'Context 2',
        ruleFunction: allTagsMatch,
      );

      await repository.add(context1);
      await repository.add(context2);

      final result = await repository.getAll();

      expect(result.length, equals(2));
      expect(result, containsAll([context1, context2]));
    });

    test('update() should modify an existing context', () async {
      final context = Context(
        id: '1',
        name: 'Initial Name',
        ruleFunction: atLeastOneTag,
      );
      await repository.add(context);

      final updatedContext = Context(
        id: '1',
        name: 'Updated Name',
        ruleFunction: allTagsMatch,
      );
      await repository.update(updatedContext);

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result?.name, equals('Updated Name'));
    });

    // Extended Test Cases

    test('add() should throw an exception for duplicate IDs', () async {
      final context1 = Context(
        id: '1',
        name: 'Context 1',
        ruleFunction: atLeastOneTag,
      );
      final context2 = Context(
        id: '1',
        name: 'Duplicate Context',
        ruleFunction: allTagsMatch,
      );

      await repository.add(context1);

      expect(
        () async => await repository.add(context2),
        throwsA(isA<ArgumentError>()),
      );

      final result = await repository.getAll();
      expect(result.length, equals(1));
      expect(result.first.name, equals('Context 1'));
    });

    test('delete() should throw an exception if the id does not exist', () async {
      expect(
        () async => await repository.delete('non-existent-id'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('update() should throw an exception if the context does not exist', () async {
      final updatedContext = Context(
        id: 'non-existent-id',
        name: 'Updated Name',
        ruleFunction: allTagsMatch,
      );

      expect(
        () async => await repository.update(updatedContext),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('getById() should return null for non-existent id', () async {
      final result = await repository.getById('non-existent-id');

      expect(result, isNull);
    });

    test('getAll() should return an unmodifiable list', () async {
      final context = Context(
        id: '1',
        name: 'Test Context',
        ruleFunction: atLeastOneTag,
      );
      await repository.add(context);

      final result = await repository.getAll();

      expect(() => result.add(context), throwsUnsupportedError);
    });

    test('ruleFunction atLeastOneTag should filter actions correctly', () async {
      final context = Context(
        id: '1',
        name: 'Test Context',
        ruleFunction: atLeastOneTag,
      );
      final action = NamAction(id: '1', title: 'Action 1', tags: ['tag1', 'tag2']);

      final result = context.ruleFunction(action, ['tag1']);

      expect(result, isTrue);
    });

    test('ruleFunction allTagsMatch should filter actions correctly', () async {
      final context = Context(
        id: '2',
        name: 'Test Context 2',
        ruleFunction: allTagsMatch,
      );
      final action = NamAction(id: '1', title: 'Action 1', tags: ['tag1', 'tag2']);

      final result = context.ruleFunction(action, ['tag1', 'tag2']);
      expect(result, isTrue);

      final resultFalse = context.ruleFunction(action, ['tag1', 'tag3']);
      expect(resultFalse, isFalse);
    });
  });
}
