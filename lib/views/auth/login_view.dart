import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/routes.dart';
import 'package:frontend_hackathon_mobile/views/auth/widgets/custom_submit_buttom.dart';
import 'package:frontend_hackathon_mobile/views/shared/widgets/custom_input_text.dart';
import 'package:frontend_hackathon_mobile/views/shared/widgets/utils/form_validators.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isFormValid = false;

  void _validateAndCheckEnabled() {
    setState(() {
      _isFormValid =
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          (_formKey.currentState?.validate() ?? false);
    });
  }

  void _handleClearFields() {
    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> _handleFormSubmit() async {
    if (mounted) {
      _handleClearFields();
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Login realizado com sucesso!',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
      );
    }

    // final authProvider = context.read<UserAuthProvider>();

    // bool success = await authProvider.handleLoginUsuario(
    //   LoginRequest(email: _emailController.text, senha: _passwordController.text),
    // );

    // if (success) {
    //   _handleClearFields();
    //   if (mounted) {
    //     Navigator.pushNamedAndRemoveUntil(context, Routes.dashboard, (route) => false);
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(
    //           'Login realizado com sucesso!',
    //           style: TextStyle(color: Theme.of(context).colorScheme.primary),
    //         ),
    //         backgroundColor: Colors.lightGreen,
    //       ),
    //     );
    //   }
    // } else {
    //   if (mounted) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(
    //           authProvider.errorMessage!,
    //           style: TextStyle(color: Theme.of(context).colorScheme.primary),
    //         ),
    //         backgroundColor: Colors.yellowAccent,
    //         duration: const Duration(seconds: 4),
    //       ),
    //     );
    //   }
    // }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.login,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              CustomInputTextWidget(
                controller: _emailController,
                labelText: 'E-mail',
                hintText: 'Digite seu email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validatores: [
                  (v) => validateRequiredField(v),
                  (v) => validateEmail(v),
                ],
                onChanged: (_) => _validateAndCheckEnabled(),
              ),
              const SizedBox(height: 16),
              CustomInputTextWidget(
                controller: _passwordController,
                labelText: 'Senha',
                hintText: 'Digite sua senha',
                prefixIcon: Icons.lock,
                obscureText: true,
                validatores: [
                  (v) => validateRequiredField(v),
                  (v) => validateMinimumLength(v, minimo: 6),
                ],
                onChanged: (_) => _validateAndCheckEnabled(),
              ),
              const SizedBox(height: 24),
              CustomSubmitButton(
                onPressed: _isFormValid ? _handleFormSubmit : null,
                text: 'Entrar',
              ),
              // Consumer<UserAuthProvider>(
              //   builder: (context, provider, child) {
              //     return CustomSubmitButton(
              //       onPressed: _isFormValid
              //           ? (provider.isLoading ? null : _handleFormSubmit)
              //           : null,
              //       text: 'Entrar',
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
