import 'package:collection/collection.dart';
import 'package:nam_app/core/abstractions/services/project_service.dart';
import 'package:nam_app/core/entities/project.dart';

class InMemoryProjectService implements ProjectService {
  final List<Project> _projects = [
    Project(
        id: '1',
        title: 'Work',
        description: 'Work-related tasks',
        parentId: null),
    Project(
        id: '2',
        title: 'Home',
        description: 'Home-related tasks',
        parentId: null),
    Project(
        id: '3',
        title: 'Errands',
        description: 'Errand-related tasks',
        parentId: null),
  ];

  @override
  Future<List<Project>> getAllProjects() async {
    return _projects;
  }

  @override
  Future<Project?> getProjectById(String id) async {
    return _projects.firstWhereOrNull((project) => project.id == id);
  }

  @override
  Future<void> addProject(Project project) async {
    _projects.add(project);
  }

  @override
  Future<void> updateProject(Project project) async {
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index != -1) {
      _projects[index] = project;
    }
  }

  @override
  Future<void> deleteProject(String id) async {
    _projects.removeWhere((project) => project.id == id);
  }
}
