import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_hackathon_mobile/views/shared/widgets/utils/form_validators.dart';

class CustomInputTextWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<String? Function(String?)>? validatores;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatter;

  const CustomInputTextWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validatores,
    this.onChanged,
    this.inputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        floatingLabelStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      cursorColor: Theme.of(context).colorScheme.primary,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validators(validatores ?? []),
      autocorrect: false,
      inputFormatters: inputFormatter,
      onChanged: onChanged,
    );
  }
}
