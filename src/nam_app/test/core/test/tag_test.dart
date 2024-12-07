import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/tag.dart';

void main() {
  group('Tag Entity Tests', () {
    test('should create a Tag with default color', () {
      final tag = Tag(id: '1', name: 'urgent');

      expect(tag.id, '1');
      expect(tag.name, 'urgent');
      expect(tag.color, '#000000'); // Default color
    });

    test('should create a Tag with a custom color', () {
      final tag = Tag(id: '2', name: 'next', color: '#FF5733');

      expect(tag.id, '2');
      expect(tag.name, 'next');
      expect(tag.color, '#FF5733');
    });

    test('toString should return the correct format', () {
      final tag = Tag(id: '3', name: 'shopping', color: '#00FF00');

      expect(tag.toString(), 'Tag(id: 3, name: shopping, color: #00FF00)');
    });
  });
}
