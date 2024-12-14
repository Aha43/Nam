// test/infrastructure/repositories/in_memory_project_repository_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/project.dart';
import 'package:nam_app/infrastructure/repositories/in_memory/in_memory_project_repository.dart';

void main() {
  group('InMemoryProjectRepository', () {
    late InMemoryProjectRepository repository;

    setUp(() {
      repository = InMemoryProjectRepository();
    });

    test('add() should store a project', () async {
      final project = Project(id: '1', title: 'Test Project', description: 'A sample project');

      await repository.add(project);
      final result = await repository.getAll();

      expect(result, contains(project));
    });

    test('getById() should retrieve the correct project', () async {
      final project = Project(id: '1', title: 'Test Project', description: 'A sample project');
      await repository.add(project);

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result?.id, equals('1'));
      expect(result?.title, equals('Test Project'));
    });

    test('delete() should remove the project by id', () async {
      final project = Project(id: '1', title: 'Test Project', description: 'A sample project');
      await repository.add(project);

      await repository.delete('1');
      final result = await repository.getById('1');

      expect(result, isNull);
    });

    test('getAll() should return all stored projects', () async {
      final project1 = Project(id: '1', title: 'Project 1', description: 'First project');
      final project2 = Project(id: '2', title: 'Project 2', description: 'Second project');

      await repository.add(project1);
      await repository.add(project2);

      final result = await repository.getAll();

      expect(result.length, equals(2));
      expect(result, containsAll([project1, project2]));
    });

    test('update() should modify an existing project', () async {
      final project = Project(id: '1', title: 'Initial Title', description: 'Initial description');
      await repository.add(project);

      final updatedProject = Project(
        id: '1',
        title: 'Updated Title',
        description: 'Updated description',
      );
      await repository.update(updatedProject);

      final result = await repository.getById('1');

      expect(result, isNotNull);
      expect(result?.title, equals('Updated Title'));
      expect(result?.description, equals('Updated description'));
    });
  });
}
