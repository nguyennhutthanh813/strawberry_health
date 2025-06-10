import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
        super.key,
        required this.icon,
        required this.hint,
        this.label,
        this.inputType = TextInputType.name,
        this.inputAction = TextInputAction.next,
        this.secure = false,
        required this.controller
      });

  final IconData icon;
  final String hint;
  final String? label;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool secure;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
            controller: controller,
            decoration: InputDecoration(
                labelText: label,
                prefixIcon: Icon(icon),
                hintText: hint,
            ),
            obscureText: secure
        )
    );
  }
}