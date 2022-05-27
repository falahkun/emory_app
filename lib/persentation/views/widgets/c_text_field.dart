import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final bool? invisible;
  final bool? enable;
  final String labelText;
  final String hintText;
  final Widget? suffixWidget;

  const CTextField(
      {Key? key,
      required this.controller,
      this.onChanged,
      this.enable = true,
      this.validator,
      this.invisible = false,
      required this.labelText,
      required this.hintText,
      this.suffixWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      key: key,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: invisible!,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: labelText,
          hintText: hintText,
          suffixIcon: suffixWidget),
    );
  }
}
