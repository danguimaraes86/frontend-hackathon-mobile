import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/providers/authentication_provider.dart';
import 'package:frontend_hackathon_mobile/shared/widgets/authenticated_app_bar.dart';
import 'package:frontend_hackathon_mobile/views/dashboard/widgets/dashboard_full_details.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthenticatedAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DashboardCard(
            userName:
                context.read<AuthenticationProvider>().user?.name ?? 'Usuário',
            taskStatuses: [
              TaskStatus(
                label: 'Pendente',
                icon: Icons.assignment_late,
                count: 3,
                value: 'pending',
              ),
              TaskStatus(
                label: 'Em Progresso',
                icon: Icons.pending_actions,
                count: 3,
                value: 'in_progress',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
