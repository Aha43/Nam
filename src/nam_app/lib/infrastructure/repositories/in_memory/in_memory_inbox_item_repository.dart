import 'package:nam_app/core/entities/inbox_item.dart';
import 'package:nam_app/core/abstractions/repositories/repositories.dart';
import 'package:nam_app/core/storage/entity_memory.dart';

class InMemoryInboxItemRepository implements InboxItemRepository {
  final EntityMemory<InboxItem> _items = EntityMemory();

  @override
  Future<List<InboxItem>> getAll() async {
    return _items.getAll();
  }

  @override
  Future<InboxItem?> getById(String id) async {
    return _items.get(id);
  }

  @override
  Future<void> add(InboxItem inboxItem) async {
    _items.add(inboxItem);
  }

  @override
  Future<void> update(InboxItem inboxItem) async {
    _items.update(inboxItem);
  }

  @override
  Future<void> delete(String id) async {
    _items.delete(id);
  }
}
