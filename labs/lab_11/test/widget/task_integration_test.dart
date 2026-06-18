import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/repositories/task_repository.dart';
import 'package:taskly/screens/task_list_screen.dart';

void main() {
  testWidgets(
    'full flow: add, open detail, edit, save, and verify list update',
    (WidgetTester tester) async {
      // Arrange
      final TaskRepository repository = TaskRepository();

      await tester.pumpWidget(
        MaterialApp(
          home: TaskListScreen(repository: repository),
        ),
      );

      // Act 1: Add Original title
      await tester.enterText(
        find.byKey(const Key('taskInputField')),
        'Original title',
      );

      await tester.tap(
        find.byKey(const Key('addTaskButton')),
      );

      await tester.pump();

      // Act 2: Open detail screen
      await tester.tap(find.text('Original title'));
      await tester.pumpAndSettle();

      // Act 3: Edit title and save
      await tester.enterText(
        find.byKey(const Key('detailTitleField')),
        'Updated title',
      );

      await tester.tap(
        find.byKey(const Key('saveTaskButton')),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Updated title'), findsOneWidget);
      expect(find.text('Original title'), findsNothing);
    },
  );
}