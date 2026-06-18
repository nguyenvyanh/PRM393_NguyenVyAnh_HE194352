import 'package:flutter/material.dart';

import '../models/task.dart';
import '../repositories/task_repository.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({
    super.key,
    required this.repository,
  });

  final TaskRepository repository;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.repository.addListener(_onRepositoryChanged);
  }

  @override
  void dispose() {
    widget.repository.removeListener(_onRepositoryChanged);
    _taskController.dispose();
    super.dispose();
  }

  void _onRepositoryChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _addTask() {
    final String title = _taskController.text.trim();

    if (title.isEmpty) {
      return;
    }

    widget.repository.addTask(title);
    _taskController.clear();
  }

  void _openTaskDetail(Task task) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return TaskDetailScreen(
            repository: widget.repository,
            task: task,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = widget.repository.tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    key: const Key('taskInputField'),
                    controller: _taskController,
                    decoration: const InputDecoration(
                      labelText: 'New task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  key: const Key('addTaskButton'),
                  onPressed: _addTask,
                  icon: const Icon(Icons.add),
                  tooltip: 'Add task',
                ),
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? const Center(
                    child: Text('No tasks yet. Add one!'),
                  )
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Task task = tasks[index];

                      return ListTile(
                        key: ValueKey<String>('task_tile_${task.id}'),
                        leading: Checkbox(
                          value: task.completed,
                          onChanged: (_) {
                            widget.repository.toggleTask(task.id);
                          },
                        ),
                        title: Text(task.title),
                        trailing: IconButton(
                          key: ValueKey<String>('delete_task_${task.id}'),
                          onPressed: () {
                            widget.repository.deleteTask(task.id);
                          },
                          icon: const Icon(Icons.delete),
                          tooltip: 'Delete task',
                        ),
                        onTap: () {
                          _openTaskDetail(task);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}