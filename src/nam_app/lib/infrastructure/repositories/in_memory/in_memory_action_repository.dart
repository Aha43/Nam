// lib/infrastructure/repositories/in_memory_action_repository.dart

import 'package:collection/collection.dart';
import 'package:nam_app/core/entities/action.dart';
import 'package:nam_app/core/abstractions/repositories/repositories.dart';


class InMemoryActionRepository implements ActionRepository {
  final List<Action> _actions = [];

  @override
  Future<void> add(Action entity) async {
    _actions.add(entity);
  }

  @override
  Future<void> delete(String id) async {
    _actions.removeWhere((action) => action.id == id);
  }

  @override
  Future<List<Action>> getAll() async {
    return List.unmodifiable(_actions);
  }

  @override
  Future<Action?> getById(String id) async {
    return _actions.firstWhereOrNull((action) => action.id == id);
  }

  @override
  Future<void> update(Action entity) async {
    final index = _actions.indexWhere((action) => action.id == entity.id);
    if (index != -1) {
      _actions[index] = entity;
    }
  }
}
