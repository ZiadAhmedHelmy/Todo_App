import 'package:flutter/material.dart';
import 'package:taskapp/utils/Colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? icon;
  final Color? iconColor;
  final Color? borderColor;
  final double? height;
  final int? maxLine;

  final String? Function(String?)? validator;

  CustomTextField({
    required this.controller,
    required this.hintText,
    this.icon,
    this.iconColor,
    this.borderColor,
    this.validator,
    this.height,
    this.maxLine
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height ,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: hintText,
            prefixIcon: icon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            contentPadding: const EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          validator: validator,
        ),
      ),
    );
  }
}
