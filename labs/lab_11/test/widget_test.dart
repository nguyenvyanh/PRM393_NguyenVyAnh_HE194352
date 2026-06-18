import 'package:flutter_test/flutter_test.dart';
import 'package:taskly/main.dart';
import 'package:taskly/repositories/task_repository.dart';

void main() {
  testWidgets('Taskly app shows app title', (WidgetTester tester) async {
    await tester.pumpWidget(
      TasklyApp(
        repository: TaskRepository(),
      ),
    );

    expect(find.text('Taskly'), findsOneWidget);
  });
}