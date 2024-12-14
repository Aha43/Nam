import 'package:collection/collection.dart';
import 'package:nam_app/core/entities/inbox_item.dart';
import 'package:nam_app/core/abstractions/repositories.dart';

class InMemoryInboxItemRepository implements InboxItemRepository {
  final List<InboxItem> _items = [];

  @override
  Future<List<InboxItem>> getAll() async {
    return _items;
  }

  @override
  Future<InboxItem?> getById(String id) async {
    
      return _items.firstWhereOrNull((element) => element.id == id);
  }

  @override
  Future<void> add(InboxItem inboxItem) async {
    if (_items.any((item) => item.id == inboxItem.id)) {
      throw Exception('InboxItem with id ${inboxItem.id} already exists.');
    }
    _items.add(inboxItem);
  }

  @override
  Future<void> update(InboxItem inboxItem) async {
    final index = _items.indexWhere((item) => item.id == inboxItem.id);
    if (index == -1) {
      throw Exception('InboxItem with id ${inboxItem.id} not found.');
    }
    _items[index] = inboxItem;
  }

  @override
  Future<void> delete(String id) async {
    _items.removeWhere((item) => item.id == id);
  }
}
