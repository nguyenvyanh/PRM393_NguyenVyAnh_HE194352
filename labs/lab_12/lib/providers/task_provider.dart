import 'package:flutter/foundation.dart';

import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = <Task>[];
  int _nextId = 1;

  List<Task> get tasks => List<Task>.unmodifiable(_tasks);

  Task? getTaskById(int id) {
    try {
      return _tasks.firstWhere((Task task) => task.id == id);
    } catch (_) {
      return null;
    }
  }

  void addTask(String title) {
    final String trimmedTitle = title.trim();

    if (trimmedTitle.isEmpty) {
      return;
    }

    final Task newTask = Task(
      id: _nextId,
      title: trimmedTitle,
    );

    _nextId++;
    _tasks.add(newTask);

    notifyListeners();
  }

  void deleteTask(int id) {
    _tasks.removeWhere((Task task) => task.id == id);

    notifyListeners();
  }

  void toggleTask(int id) {
    final int index = _tasks.indexWhere((Task task) => task.id == id);

    if (index == -1) {
      return;
    }

    final Task oldTask = _tasks[index];

    _tasks[index] = oldTask.copyWith(
      completed: !oldTask.completed,
    );

    notifyListeners();
  }

  void updateTaskTitle({
    required int id,
    required String title,
  }) {
    final String trimmedTitle = title.trim();

    if (trimmedTitle.isEmpty) {
      return;
    }

    final int index = _tasks.indexWhere((Task task) => task.id == id);

    if (index == -1) {
      return;
    }

    final Task oldTask = _tasks[index];

    _tasks[index] = oldTask.copyWith(
      title: trimmedTitle,
    );

    notifyListeners();
  }
}