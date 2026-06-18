import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/repositories/task_repository.dart';
import 'package:taskly/screens/task_list_screen.dart';

Future<void> pumpTaskListScreen(
  WidgetTester tester,
  TaskRepository repository,
) async {
  await tester.pumpWidget(
    MaterialApp(
      home: TaskListScreen(repository: repository),
    ),
  );
}

void main() {
  group('TaskListScreen widget tests', () {
    testWidgets('shows empty state when there are no tasks', (
      WidgetTester tester,
    ) async {
      // Arrange
      final TaskRepository repository = TaskRepository();

      // Act
      await pumpTaskListScreen(tester, repository);

      // Assert
      expect(find.text('No tasks yet. Add one!'), findsOneWidget);
    });

    testWidgets('adds a task and updates the UI', (
      WidgetTester tester,
    ) async {
      // Arrange
      final TaskRepository repository = TaskRepository();
      await pumpTaskListScreen(tester, repository);

      // Act
      await tester.enterText(
        find.byKey(const Key('taskInputField')),
        'Buy milk',
      );

      await tester.tap(
        find.byKey(const Key('addTaskButton')),
      );

      await tester.pump();

      // Assert
      expect(find.text('Buy milk'), findsOneWidget);
      expect(find.text('No tasks yet. Add one!'), findsNothing);
    });

    testWidgets('adds multiple tasks and shows both in the list', (
      WidgetTester tester,
    ) async {
      // Arrange
      final TaskRepository repository = TaskRepository();
      await pumpTaskListScreen(tester, repository);

      // Act
      await tester.enterText(
        find.byKey(const Key('taskInputField')),
        'Task A',
      );
      await tester.tap(find.byKey(const Key('addTaskButton')));
      await tester.pump();

      await tester.enterText(
        find.byKey(const Key('taskInputField')),
        'Task B',
      );
      await tester.tap(find.byKey(const Key('addTaskButton')));
      await tester.pump();

      // Assert
      expect(find.text('Task A'), findsOneWidget);
      expect(find.text('Task B'), findsOneWidget);
    });
  });
}