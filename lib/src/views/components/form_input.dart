import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextForm extends StatelessWidget {
  const TextForm(
    this.controller,
    this.hintText, {
    super.key,
    this.isObsecure,
    this.validator,
    this.textInputType,
    this.maxLength,
    this.prefix,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String hintText;
  final bool? isObsecure;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final int? maxLength;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
        inputFormatters: inputFormatters,
        obscureText: isObsecure ?? false,
        controller: controller,
        validator: validator,
        keyboardType: textInputType,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          counterText: '',
          prefixIcon: prefix,
        ),
      ),
    );
  }
}
