// lib/infrastructure/repositories/in_memory_context_repository.dart

import 'package:collection/collection.dart';
import 'package:nam_app/core/entities/context.dart';
import 'package:nam_app/core/abstractions/repositories/repositories.dart';

class InMemoryContextRepository implements ContextRepository {
  final List<Context> _contexts = [];

  @override
  Future<void> add(Context context) async {
    _contexts.add(context);
  }

  @override
  Future<void> delete(String id) async {
    _contexts.removeWhere((context) => context.id == id);
  }

  @override
  Future<List<Context>> getAll() async {
    return List.unmodifiable(_contexts);
  }

  @override
  Future<Context?> getById(String id) async {
    return _contexts.firstWhereOrNull((context) => context.id == id);
  }

  @override
  Future<void> update(Context updatedContext) async {
    final index = _contexts.indexWhere((context) => context.id == updatedContext.id);
    if (index != -1) {
      _contexts[index] = updatedContext;
    }
  }
}
