import 'package:nam_app/core/abstractions/entity.dart';
import 'package:uuid/uuid.dart';

class Tag implements Entity {
  final String id; // Unique identifier
  String name; // Tag name (e.g., "next", "urgent")
  String color; // Optional color code for the tag (e.g., "#FF0000")

  Tag({
    String? id,
    required this.name,
    this.color = '#000000', // Default to black if no color is provided
  }) : id = id ?? const Uuid().v4();

  @override
  String getId() => id;

  @override
  String toString() => 'Tag(id: $id, name: $name, color: $color)';
}
