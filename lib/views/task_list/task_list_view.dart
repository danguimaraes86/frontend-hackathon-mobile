import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/authenticated_app_bar.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AuthenticatedAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('tarefas'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: colorScheme.primaryContainer,
        child: Icon(
          Icons.add,
          color: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
