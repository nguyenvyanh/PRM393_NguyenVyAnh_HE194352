import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({
    super.key,
    required this.taskId,
  });

  final int taskId;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late final TextEditingController _titleController;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInitialized) {
      return;
    }

    final Task? task = context.read<TaskProvider>().getTaskById(widget.taskId);

    _titleController = TextEditingController(
      text: task?.title ?? '',
    );

    _isInitialized = true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveTask() {
    context.read<TaskProvider>().updateTaskTitle(
          id: widget.taskId,
          title: _titleController.text,
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<TaskProvider, Task?>(
      selector: (_, TaskProvider provider) {
        return provider.getTaskById(widget.taskId);
      },
      builder: (
        BuildContext context,
        Task? task,
        Widget? child,
      ) {
        if (task == null) {
          return const Scaffold(
            body: Center(
              child: Text('Task not found'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Task Detail'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  key: const Key('detailTitleField'),
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Task title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  key: const Key('saveTaskButton'),
                  onPressed: _saveTask,
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                ),
                const SizedBox(height: 16),
                Text(
                  task.completed ? 'Status: Completed' : 'Status: Pending',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}