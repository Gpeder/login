import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


class CustomTextFormField extends StatelessWidget {

  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final MaskTextInputFormatter mask;

  const CustomTextFormField({
    super.key,
    required this.obscureText,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.labelText, required this.mask,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      inputFormatters: [mask],
    );
  }
}