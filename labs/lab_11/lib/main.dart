import 'package:flutter/material.dart';

import 'repositories/task_repository.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(
    TasklyApp(
      repository: TaskRepository(),
    ),
  );
}

class TasklyApp extends StatelessWidget {
  const TasklyApp({
    super.key,
    required this.repository,
  });

  final TaskRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskly',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: TaskListScreen(repository: repository),
    );
  }
}