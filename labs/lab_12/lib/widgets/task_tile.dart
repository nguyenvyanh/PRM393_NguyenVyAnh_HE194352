import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/task_detail_screen.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.taskId,
  });

  final int taskId;

  void _openDetailScreen(BuildContext context, Task task) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) {
          return TaskDetailScreen(taskId: task.id);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<TaskProvider, Task?>(
      selector: (_, TaskProvider provider) {
        return provider.getTaskById(taskId);
      },
      builder: (
        BuildContext context,
        Task? task,
        Widget? child,
      ) {
        if (task == null) {
          return const SizedBox.shrink();
        }

        return ListTile(
          key: ValueKey<String>('task_tile_${task.id}'),
          leading: Checkbox(
            value: task.completed,
            onChanged: (_) {
              context.read<TaskProvider>().toggleTask(task.id);
            },
          ),
          title: Text(
            task.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            task.completed ? 'Completed' : 'Pending',
          ),
          trailing: IconButton(
            key: ValueKey<String>('delete_task_${task.id}'),
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete task',
            onPressed: () {
              context.read<TaskProvider>().deleteTask(task.id);
            },
          ),
          onTap: () {
            _openDetailScreen(context, task);
          },
        );
      },
    );
  }
}