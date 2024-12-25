// lib/infrastructure/repositories/in_memory_context_repository.dart

import 'package:nam_app/core/entities/context.dart';
import 'package:nam_app/core/abstractions/repositories/repositories.dart';
import 'package:nam_app/core/storage/entity_memory.dart';

class InMemoryContextRepository implements ContextRepository {
  final EntityMemory<Context> _contexts = EntityMemory();

  @override
  Future<void> add(Context context) async {
    _contexts.add(context);
  }

  @override
  Future<void> delete(String id) async {
    _contexts.delete(id);
  }

  @override
  Future<List<Context>> getAll() async {
    return _contexts.getAll();
  }

  @override
  Future<Context?> getById(String id) async {
    return _contexts.get(id);
  }

  @override
  Future<void> update(Context updatedContext) async {
    _contexts.update(updatedContext);
  }
}
