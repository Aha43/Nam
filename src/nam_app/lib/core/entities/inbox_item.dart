// InboxItem Class Definition
import 'package:nam_app/core/abstractions/entity.dart';
import 'package:uuid/uuid.dart';

class InboxItem implements Entity {
  final String id; // Unique identifier for the inbox item
  String content; // The raw content of the item
  DateTime createdAt; // Timestamp of when the item was created
  

  InboxItem({
    String? id,
    required this.content,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  @override
  String getId() => id;

  @override
  String toString() {
    return 'InboxItem(id: $id, content: $content, createdAt: $createdAt)';
  }

}
