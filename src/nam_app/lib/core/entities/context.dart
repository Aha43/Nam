import 'package:nam_app/core/entities/action.dart';
import 'package:uuid/uuid.dart';

typedef RuleFunction = bool Function(NamAction action, List<String> tags);

bool atLeastOneTag(NamAction action, List<String> tags) {
  return tags.any((tag) => action.tags.contains(tag));
}

bool allTagsMatch(NamAction action, List<String> tags) {
  return tags.every((tag) => action.tags.contains(tag));
}

class Context {
  final String id; // Unique identifier for the context
  String name; // Name of the context
  String? description; // Optional description of the context
  List<String> tags; // Tags associated with the context
  final RuleFunction ruleFunction;
  bool isReadOnly; // Indicates if the context is read-only

  Context({
    String? id,
    required this.name,
    this.description,
    List<String>? tags,
    required this.ruleFunction,
    this.isReadOnly = false,
  })  : id = id ?? const Uuid().v4(),
        tags = tags ?? [];

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
