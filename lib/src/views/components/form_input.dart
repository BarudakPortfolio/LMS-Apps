import 'package:flutter/material.dart';

import '../../core/style/theme.dart';

class TextForm extends StatelessWidget {
  const TextForm(
    this.controller,
    this.hintText, {
    super.key,
    this.isObsecure,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final bool? isObsecure;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        obscureText: isObsecure ?? false,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          isDense: true,
          isCollapsed: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: const Color(0xffEDEDED),
          filled: true,
          labelStyle: const TextStyle(color: kGreenPrimary),
          contentPadding: const EdgeInsets.all(15),
          hintText: hintText,
          hintStyle: const TextStyle(color: kGreen),
        ),
      ),
    );
  }
}
