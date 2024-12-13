import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/project.dart';

void main() {
  group('Project Entity Tests', () {
    test('should create a Project with default values', () {
      final project = Project(id: '1', title: 'Test Project');

      expect(project.id, '1');
      expect(project.title, 'Test Project');
      expect(project.description, isNull);
      expect(project.actions, isEmpty);
      expect(project.subprojects, isEmpty);
      expect(project.tags, isEmpty);
    });

    test('should create a Project with custom values', () {
      final project = Project(
        id: '2',
        title: 'Custom Project',
        description: 'A detailed description',
        actions: ['action1', 'action2'],
        subprojects: ['subproject1'],
        tags: ['tag1', 'tag2'],
      );

      expect(project.id, '2');
      expect(project.title, 'Custom Project');
      expect(project.description, 'A detailed description');
      expect(project.actions, equals(['action1', 'action2']));
      expect(project.subprojects, equals(['subproject1']));
      expect(project.tags, equals(['tag1', 'tag2']));
    });

    test('should add and remove actions', () {
      final project = Project(id: '3', title: 'Action Project');

      project.addAction('action1');
      project.addAction('action2');
      expect(project.actions, equals(['action1', 'action2']));

      project.removeAction('action1');
      expect(project.actions, equals(['action2']));
    });

    test('should add and remove subprojects', () {
      final project = Project(id: '4', title: 'Subproject Project');

      project.addSubproject('subproject1');
      project.addSubproject('subproject2');
      expect(project.subprojects, equals(['subproject1', 'subproject2']));

      project.removeSubproject('subproject1');
      expect(project.subprojects, equals(['subproject2']));
    });

    test('toString should return the correct format', () {
      final project = Project(
        id: '5',
        title: 'Stringify Project',
        description: 'String description',
        actions: ['action1'],
        subprojects: ['subproject1'],
        tags: ['tag1'],
      );

      expect(
        project.toString(),
        'Project(id: 5, title: Stringify Project, description: String description, '
        'actions: [action1], subprojects: [subproject1], tags: [tag1])',
      );
    });
  });
}
