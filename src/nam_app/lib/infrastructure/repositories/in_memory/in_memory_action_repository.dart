// lib/infrastructure/repositories/in_memory_action_repository.dart

import 'package:nam_app/core/entities/action.dart';
import 'package:nam_app/core/abstractions/repositories/repositories.dart';
import 'package:nam_app/core/storage/entity_memory.dart';

class InMemoryActionRepository implements ActionRepository {
  final EntityMemory<NamAction> _actions = EntityMemory();

  @override
  Future<void> add(NamAction entity) async {
    _actions.add(entity);
  }

  @override
  Future<void> delete(String id) async {
    _actions.delete(id);
  }

  @override
  Future<List<NamAction>> getAll() async {
    return _actions.getAll();
  }

  @override
  Future<NamAction?> getById(String id) async {
    return _actions.get(id);
  }

  @override
  Future<void> update(NamAction entity) async {
    _actions.update(entity);
  }
}
