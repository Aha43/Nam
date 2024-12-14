// InboxItem Class Definition
class InboxItem {
  final String id; // Unique identifier for the inbox item
  String content; // The raw content of the item
  DateTime createdAt; // Timestamp of when the item was created
  String? actionId; // Optional ID of an associated action
  String? projectId; // Optional ID of an associated project

  InboxItem({
    required this.id,
    required this.content,
    DateTime? createdAt,
    this.actionId,
    this.projectId,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  String toString() {
    return 'InboxItem(id: $id, content: $content, createdAt: $createdAt, '
           'actionId: $actionId, projectId: $projectId)';
  }

  bool isProcessed() {
    return actionId != null || projectId != null;
  }
}
