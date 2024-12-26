import 'package:nam_app/core/abstractions/repositories/repositories.dart';
import 'package:nam_app/core/entities/tag.dart';
import 'package:nam_app/core/storage/entity_memory.dart';

class InMemoryTagRepository implements TagRepository {
  final EntityMemory<Tag> _memory = EntityMemory();

  @override
  Future<void> add(Tag tag) async {
    _memory.add(tag);
  }

  @override
  Future<void> delete(String id) async {
    _memory.delete(id);
  }

  @override
  Future<List<Tag>> getAll() async {
    return _memory.getAll();
  }

  @override
  Future<Tag?> getById(String id) async {
    return _memory.get(id);
  }

  @override
  Future<void> update(Tag tag) async {
    _memory.update(tag);
  }
}
