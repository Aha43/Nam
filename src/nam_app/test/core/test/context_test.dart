import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/context.dart';

void main() {
  group('Context Entity Tests', () {
    test('should create a Context with default values', () {
      final context = Context(id: '1', name: 'Test Context');

      expect(context.id, '1');
      expect(context.name, 'Test Context');
      expect(context.description, isNull);
      expect(context.tags, isEmpty);
      expect(context.isReadOnly, isFalse);
    });

    test('should create a Context with custom values', () {
      final context = Context(
        id: '2',
        name: 'Custom Context',
        description: 'A detailed description',
        tags: ['tag1', 'tag2'],
        isReadOnly: true,
      );

      expect(context.id, '2');
      expect(context.name, 'Custom Context');
      expect(context.description, 'A detailed description');
      expect(context.tags, equals(['tag1', 'tag2']));
      expect(context.isReadOnly, isTrue);
    });

    test('should add and remove tags when not read-only', () {
      final context = Context(id: '3', name: 'Editable Context');

      context.addTag('tag1');
      context.addTag('tag2');
      expect(context.tags, equals(['tag1', 'tag2']));

      context.removeTag('tag1');
      expect(context.tags, equals(['tag2']));
    });

    test('should not add or remove tags when read-only', () {
      final context = Context(id: '4', name: 'Read-Only Context', isReadOnly: true);

      context.addTag('tag1');
      expect(context.tags, isEmpty);

      context.removeTag('tag1'); // Should have no effect
      expect(context.tags, isEmpty);
    });

    test('toString should return the correct format', () {
      final context = Context(
        id: '5',
        name: 'Stringify Context',
        description: 'String description',
        tags: ['tag1'],
        isReadOnly: true,
      );

      expect(
        context.toString(),
        'Context(id: 5, name: Stringify Context, description: String description, '
        'tags: [tag1], isReadOnly: true)',
      );
    });
  });
}
