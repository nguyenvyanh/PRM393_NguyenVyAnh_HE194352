import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/repositories/task_repository.dart';

void main() {
  group('TaskRepository', () {
    test('addTask adds a new task', () {
      // Arrange
      final TaskRepository repository = TaskRepository();

      // Act
      final Task task = repository.addTask('Finish Lab 11');

      // Assert
      expect(repository.tasks.length, 1);
      expect(repository.tasks.first.title, 'Finish Lab 11');
      expect(task.completed, isFalse);
    });

    test('deleteTask removes a task by id', () {
      // Arrange
      final TaskRepository repository = TaskRepository();
      final Task task = repository.addTask('Temporary task');

      // Act
      repository.deleteTask(task.id);

      // Assert
      expect(repository.tasks, isEmpty);
    });

    test('updateTask changes an existing task', () {
      // Arrange
      final TaskRepository repository = TaskRepository();
      final Task task = repository.addTask('Old title');
      final Task updatedTask = task.copyWith(
        title: 'New title',
        completed: true,
      );

      // Act
      repository.updateTask(updatedTask);

      // Assert
      expect(repository.tasks.length, 1);
      expect(repository.tasks.first.title, 'New title');
      expect(repository.tasks.first.completed, isTrue);
    });
  });
}