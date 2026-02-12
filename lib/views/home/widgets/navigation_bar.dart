import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/routes.dart';

import 'auth_buttom.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: AuthButtonWidget(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              foregroundColor: Theme.of(context).colorScheme.primary,
              path: Routes.signUp,
              icon: Icons.person_add,
              description: 'Cadastrar',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AuthButtonWidget(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              path: Routes.login,
              icon: Icons.login,
              description: 'Entrar',
            ),
          ),
        ],
      ),
    );
  }
}
