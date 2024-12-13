class Context {
  final String id;             // Unique identifier for the context
  String name;                 // Name of the context
  String? description;         // Optional description of the context
  List<String> tags;           // Tags associated with the context
  bool isReadOnly;             // Indicates if the context is read-only

  Context({
    required this.id,
    required this.name,
    this.description,
    List<String>? tags,
    this.isReadOnly = false,
  }) : tags = tags ?? [];

  void addTag(String tagId) {
    if (!isReadOnly && !tags.contains(tagId)) {
      tags.add(tagId);
    }
  }

  void removeTag(String tagId) {
    if (!isReadOnly) {
      tags.remove(tagId);
    }
  }

  @override
  String toString() {
    return 'Context(id: $id, name: $name, description: $description, '
        'tags: $tags, isReadOnly: $isReadOnly)';
  }
}
