import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/tag.dart';
import 'package:nam_app/infrastructure/repositories/in_memory/in_memory_tag_repository.dart';

void main() {
  group('InMemoryTagRepository', () {
    late InMemoryTagRepository repository;

    setUp(() {
      repository = InMemoryTagRepository();
    });

    test('add() should store a tag', () async {
      final tag = Tag(id: '1', name: 'Test Tag');

      await repository.add(tag);
      final result = await repository.getAll();

      expect(result, contains(tag));
    });

    test('getById() should retrieve the correct tag', () async {
      final tag = Tag(id: '1', name: 'Test Tag');
      await repository.add(tag);

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result?.id, equals('1'));
      expect(result?.name, equals('Test Tag'));
    });

    test('delete() should remove the tag by id', () async {
      final tag = Tag(id: '1', name: 'Test Tag');
      await repository.add(tag);

      await repository.delete('1');
      final result = await repository.getById('1');

      expect(result, isNull);
    });

    test('getAll() should return all stored tags', () async {
      final tag1 = Tag(id: '1', name: 'Tag 1');
      final tag2 = Tag(id: '2', name: 'Tag 2');

      await repository.add(tag1);
      await repository.add(tag2);

      final result = await repository.getAll();

      expect(result.length, equals(2));
      expect(result, containsAll([tag1, tag2]));
    });

    test('update() should modify an existing tag', () async {
      final tag = Tag(id: '1', name: 'Initial Name');
      await repository.add(tag);

      final updatedTag = Tag(id: '1', name: 'Updated Name');
      await repository.update(updatedTag);

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result?.name, equals('Updated Name'));
    });

    test('add() should throw an exception for duplicate IDs', () async {
      final tag1 = Tag(id: '1', name: 'Tag 1');
      final tag2 = Tag(id: '1', name: 'Duplicate Tag');

      await repository.add(tag1);

      expect(
        () async => await repository.add(tag2),
        throwsA(isA<ArgumentError>()),
      );

      final result = await repository.getAll();
      expect(result.length, equals(1));
      expect(result.first.name, equals('Tag 1'));
    });

    test('delete() should throw an exception if the id does not exist', () async {
      expect(
        () async => await repository.delete('non-existent-id'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('update() should throw an exception if the tag does not exist', () async {
      final updatedTag = Tag(id: 'non-existent-id', name: 'Updated Name');

      expect(
        () async => await repository.update(updatedTag),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('getById() should return null for non-existent id', () async {
      final result = await repository.getById('non-existent-id');

      expect(result, isNull);
    });

    test('getAll() should return an unmodifiable list', () async {
      final tag = Tag(id: '1', name: 'Test Tag');
      await repository.add(tag);

      final result = await repository.getAll();

      expect(() => result.add(tag), throwsUnsupportedError);
    });
  });
}
