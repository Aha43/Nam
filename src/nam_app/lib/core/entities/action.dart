import 'package:uuid/uuid.dart';

class NamAction {
  final String id;         // Unique identifier for the action
  String? projectId;       // Optional project ID
  String title;            // Title of the action
  String? description;     // Optional description
  bool isCompleted;        // Status of the action
  List<String> tags;       // List of associated tag IDs
  final DateTime createdAt;      // Timestamp of when the action was created

  NamAction({
    String? id,
    this.projectId,
    required this.title,
    this.description,
    this.isCompleted = false,
    List<String>? tags, 
    DateTime? createdAt,
  }) : id = id ?? const Uuid().v4(), 
    tags = tags ?? [], 
    createdAt = createdAt ?? DateTime.now();

  void complete() {
    isCompleted = true;
  }

  void uncomplete() {
    isCompleted = false;
  }

  @override
  String toString() {
    return 'Action(id: $id, title: $title, description: $description, '
        'isCompleted: $isCompleted, tags: $tags)';
  }
}
