class Tag {
  final String id; // Unique identifier
  String name;     // Tag name (e.g., "next", "urgent")
  String color;    // Optional color code for the tag (e.g., "#FF0000")

  Tag({
    required this.id,
    required this.name,
    this.color = '#000000', // Default to black if no color is provided
  });

  @override
  String toString() => 'Tag(id: $id, name: $name, color: $color)';
}
