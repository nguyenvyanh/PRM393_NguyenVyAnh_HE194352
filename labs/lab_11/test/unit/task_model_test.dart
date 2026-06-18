import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/models/task.dart';

void main() {
  group('Task model', () {
    test('default completed value is false', () {
      // Arrange
      final Task task = Task(
        id: 1,
        title: 'Read Flutter docs',
      );

      // Act
      final bool completed = task.completed;

      // Assert
      expect(completed, isFalse);
    });

    test('toggle switches completed true and false', () {
      // Arrange
      final Task task = Task(
        id: 1,
        title: 'Write unit tests',
      );

      // Act + Assert
      task.toggle();
      expect(task.completed, isTrue);

      task.toggle();
      expect(task.completed, isFalse);
    });
  });
}