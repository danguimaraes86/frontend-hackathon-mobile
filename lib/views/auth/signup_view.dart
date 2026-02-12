import 'package:flutter/material.dart';
import 'package:frontend_hackathon_mobile/configs/routes.dart';
import 'package:frontend_hackathon_mobile/views/auth/widgets/custom_submit_buttom.dart';
import 'package:frontend_hackathon_mobile/views/shared/widgets/utils/form_validators.dart';
import 'package:frontend_hackathon_mobile/views/shared/widgets/custom_input_text.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isFormValid = false;

  void _validateAndCheckEnabled() {
    setState(() {
      _isFormValid =
          _nameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.value == _confirmPasswordController.value &&
          (_formKey.currentState?.validate() ?? false);
    });
  }

  void _handleClearFields() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  Future<void> _handleFormSubmit() async {
    if (mounted) {
      _handleClearFields();
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Cadastro realizado com sucesso!',
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
      );
    }
    // final authProvider = context.read<UserAuthProvider>();

    // bool success = await authProvider.handleCadastrarUsuario(
    //   CadastroRequest(
    //     nome: _nomeController.text,
    //     email: _emailController.text,
    //     senha: _senhaController.text,
    //   ),
    // );
    // if (success) {
    //   _handleClearFields();
    //   if (mounted) {
    //     Navigator.pushNamedAndRemoveUntil(context, Routes.dashboard, (route) => false);
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(
    //           'Cadastro realizado com sucesso!',
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.person_add,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              CustomInputTextWidget(
                controller: _nameController,
                labelText: 'Nome',
                hintText: 'Digite seu nome',
                prefixIcon: Icons.person,
                validatores: [
                  (v) => validateRequiredField(v),
                  (v) => validateMinimumLength(v, minimo: 6),
                ],
                onChanged: (_) => _validateAndCheckEnabled(),
              ),

              const SizedBox(height: 16),
              CustomInputTextWidget(
                controller: _emailController,
                labelText: 'Email',
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
              const SizedBox(height: 16),
              CustomInputTextWidget(
                controller: _confirmPasswordController,
                labelText: 'Senha',
                hintText: 'Confirme sua senha',
                prefixIcon: Icons.lock,
                obscureText: true,
                validatores: [
                  (v) => validateRequiredField(v),
                  (v) => validateMinimumLength(v, minimo: 6),
                ],
                onChanged: (_) => _validateAndCheckEnabled(),
              ),
              const SizedBox(height: 40),
              CustomSubmitButton(
                onPressed: _isFormValid ? _handleFormSubmit : null,
                text: 'Cadastrar',
              ),
              // Consumer<UserAuthProvider>(
              //   builder: (context, provider, child) {
              //     return CustomSubmitButton(
              //       onPressed: _isFormValid
              //           ? (provider.isLoading ? null : _handleFormSubmit)
              //           : null,
              //       text: 'Cadastrar',
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
