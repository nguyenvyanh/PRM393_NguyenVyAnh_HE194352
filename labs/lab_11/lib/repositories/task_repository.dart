import 'package:flutter/foundation.dart';

import '../models/task.dart';

class TaskRepository extends ChangeNotifier {
  final List<Task> _tasks = <Task>[];
  int _nextId = 1;

  List<Task> get tasks => List.unmodifiable(_tasks);

  Task addTask(String title) {
    final String trimmedTitle = title.trim();

    if (trimmedTitle.isEmpty) {
      throw ArgumentError('Task title cannot be empty');
    }

    final Task task = Task(
      id: _nextId++,
      title: trimmedTitle,
    );

    _tasks.add(task);
    notifyListeners();

    return task;
  }

  void deleteTask(int id) {
    _tasks.removeWhere((Task task) => task.id == id);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final int index = _tasks.indexWhere(
      (Task task) => task.id == updatedTask.id,
    );

    if (index == -1) {
      throw StateError('Task with id ${updatedTask.id} was not found');
    }

    _tasks[index] = updatedTask;
    notifyListeners();
  }

  void toggleTask(int id) {
    final Task task = _tasks.firstWhere(
      (Task task) => task.id == id,
      orElse: () => throw StateError('Task with id $id was not found'),
    );

    task.toggle();
    notifyListeners();
  }

  void clear() {
    _tasks.clear();
    _nextId = 1;
    notifyListeners();
  }
}