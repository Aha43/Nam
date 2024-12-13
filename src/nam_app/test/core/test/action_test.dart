import 'package:flutter_test/flutter_test.dart';
import 'package:nam_app/core/entities/action.dart';

void main() {
  group('Action Entity Tests', () {
    test('should create an Action with default values', () {
      final action = Action(id: '1', title: 'Test Action');

      expect(action.id, '1');
      expect(action.title, 'Test Action');
      expect(action.description, isNull);
      expect(action.isCompleted, isFalse);
      expect(action.tags, isEmpty);
    });

    test('should create an Action with custom values', () {
      final action = Action(
        id: '2',
        title: 'Custom Action',
        description: 'A detailed description',
        isCompleted: true,
        tags: ['tag1', 'tag2'],
      );

      expect(action.id, '2');
      expect(action.title, 'Custom Action');
      expect(action.description, 'A detailed description');
      expect(action.isCompleted, isTrue);
      expect(action.tags, equals(['tag1', 'tag2']));
    });

    test('should mark the Action as completed', () {
      final action = Action(id: '3', title: 'Complete Action');

      action.complete();
      expect(action.isCompleted, isTrue);
    });

    test('should unmark the Action as completed', () {
      final action = Action(id: '4', title: 'Uncomplete Action', isCompleted: true);

      action.uncomplete();
      expect(action.isCompleted, isFalse);
    });

    test('toString should return the correct format', () {
      final action = Action(
        id: '5',
        title: 'Stringify Action',
        description: 'String description',
        tags: ['tag1'],
      );

      expect(
        action.toString(),
        'Action(id: 5, title: Stringify Action, description: String description, '
        'isCompleted: false, tags: [tag1])',
      );
    });
  });
}
