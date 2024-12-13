class Action {
  final String id;         // Unique identifier for the action
  String title;            // Title of the action
  String? description;     // Optional description
  bool isCompleted;        // Status of the action
  List<String> tags;       // List of associated tag IDs

  Action({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    List<String>? tags,
  }) : tags = tags ?? [];

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
