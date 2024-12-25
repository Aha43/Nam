import 'package:uuid/uuid.dart';

class Project {
  final String id; // Unique identifier
  String? parentId; // Optional parent project ID
  String title; // Project title
  String? description; // Optional description
  List<String> actions; // List of associated action IDs
  List<String> subprojects; // List of associated subproject IDs
  List<String> tags; // Tags for the project

  Project({
    String? id,
    required this.title,
    this.description,
    List<String>? actions,
    List<String>? subprojects,
    List<String>? tags,
    String? parentId,
  })  : id = id ?? const Uuid().v4(),
        actions = actions ?? [],
        subprojects = subprojects ?? [],
        tags = tags ?? [];

  void addAction(String actionId) {
    if (!actions.contains(actionId)) {
      actions.add(actionId);
    }
  }

  void removeAction(String actionId) {
    actions.remove(actionId);
  }

  void addSubproject(String subprojectId) {
    if (!subprojects.contains(subprojectId)) {
      subprojects.add(subprojectId);
    }
  }

  void removeSubproject(String subprojectId) {
    subprojects.remove(subprojectId);
  }

  @override
  String toString() {
    return 'Project(id: $id, title: $title, description: $description, '
        'actions: $actions, subprojects: $subprojects, tags: $tags)';
  }
}
