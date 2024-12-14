// lib/infrastructure/repositories/in_memory_project_repository.dart

import 'package:nam_app/core/entities/project.dart';
import 'package:nam_app/core/abstractions/repositories/repositories.dart';
import 'package:collection/collection.dart';

class InMemoryProjectRepository implements ProjectRepository {
  final List<Project> _projects = [];

  @override
  Future<void> add(Project entity) async {
    _projects.add(entity);
  }

  @override
  Future<void> delete(String id) async {
    _projects.removeWhere((project) => project.id == id);
  }

  @override
  Future<List<Project>> getAll() async {
    return List.unmodifiable(_projects);
  }

  @override
  Future<Project?> getById(String id) async {
    return _projects.firstWhereOrNull((project) => project.id == id);
  }

  @override
  Future<void> update(Project entity) async {
    final index = _projects.indexWhere((project) => project.id == entity.id);
    if (index != -1) {
      _projects[index] = entity;
    }
  }
}
