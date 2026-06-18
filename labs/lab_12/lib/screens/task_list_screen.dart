import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _taskController = TextEditingController();

  static const AssetImage _taskIconImage = AssetImage(
    'assets/icons/task_icon.png',
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(_taskIconImage, context);
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTask() {
    final String title = _taskController.text.trim();

    if (title.isEmpty) {
      return;
    }

    context.read<TaskProvider>().addTask(title);
    _taskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _TasklyAppBar(),
      body: Column(
        children: <Widget>[
          _AddTaskSection(
            controller: _taskController,
            onAddTask: _addTask,
            taskIconImage: _taskIconImage,
          ),
          Expanded(
            child: Selector<TaskProvider, List<Task>>(
              selector: (_, TaskProvider provider) => provider.tasks,
              builder: (
                BuildContext context,
                List<Task> tasks,
                Widget? child,
              ) {
                if (tasks.isEmpty) {
                  return child!;
                }

                return ListView.builder(
                  key: const PageStorageKey<String>('taskListView'),
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Task task = tasks[index];

                    return TaskTile(
                      key: ValueKey<int>(task.id),
                      taskId: task.id,
                    );
                  },
                );
              },
              child: const _EmptyTaskState(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TasklyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _TasklyAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Taskly'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AddTaskSection extends StatelessWidget {
  const _AddTaskSection({
    required this.controller,
    required this.onAddTask,
    required this.taskIconImage,
  });

  final TextEditingController controller;
  final VoidCallback onAddTask;
  final AssetImage taskIconImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Image(
            image: taskIconImage,
            width: 36,
            height: 36,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              key: const Key('taskInputField'),
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'New task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => onAddTask(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            key: const Key('addTaskButton'),
            onPressed: onAddTask,
            icon: const Icon(Icons.add),
            tooltip: 'Add task',
          ),
        ],
      ),
    );
  }
}

class _EmptyTaskState extends StatelessWidget {
  const _EmptyTaskState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No tasks yet. Add one!'),
    );
  }
}