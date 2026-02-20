import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/routes.dart';

class DashboardCard extends StatelessWidget {
  final String userName;
  final List<TaskStatus> taskStatuses;

  const DashboardCard({
    super.key,
    required this.userName,
    required this.taskStatuses,
  });

  String _getWelcomeMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Bom dia!';
    } else if (hour < 18) {
      return 'Boa tarde!';
    } else {
      return 'Boa noite!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasTasksCount = taskStatuses.isNotEmpty;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bem-vindo, $userName',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  _getWelcomeMessage(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Card Content
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40.0,
              horizontal: 16.0,
            ),
            child: Center(
              child: hasTasksCount
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 12,
                      children: taskStatuses.map((status) {
                        return Badge(
                          label: Text(status.count.toString()),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          child: Chip(
                            avatar: Icon(status.icon, size: 20),
                            label: Text(status.label),
                          ),
                        );
                      }).toList(),
                    )
                  : Icon(
                      Icons.self_improvement,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
            ),
          ),

          // Card Actions
          if (hasTasksCount)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.taskList);
                    },
                    icon: const Icon(Icons.task),
                    label: const Text('Ver Tarefas'),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TaskStatus {
  final String label;
  final IconData icon;
  final int count;
  final String value;

  const TaskStatus({
    required this.label,
    required this.icon,
    required this.count,
    required this.value,
  });
}
