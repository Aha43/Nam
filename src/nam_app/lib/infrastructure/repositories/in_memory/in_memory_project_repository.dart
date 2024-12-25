// lib/infrastructure/repositories/in_memory_project_repository.dart

import 'package:nam_app/core/entities/project.dart';
import 'package:nam_app/core/abstractions/repositories/repositories.dart';
import 'package:nam_app/core/storage/entity_memory.dart';

class InMemoryProjectRepository implements ProjectRepository {
  final EntityMemory<Project> _projects = EntityMemory();

  @override
  Future<void> add(Project entity) async {
    _projects.add(entity);
  }

  @override
  Future<void> delete(String id) async {
    _projects.delete(id);
  }

  @override
  Future<List<Project>> getAll() async {
    return _projects.getAll();
  }

  @override
  Future<Project?> getById(String id) async {
    return _projects.get(id);
  }

  @override
  Future<void> update(Project entity) async {
    _projects.update(entity);
  }
}
