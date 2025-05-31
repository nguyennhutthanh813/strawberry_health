import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key,
        required this.icon,
        required this.hint,
        this.label,
        this.inputType = TextInputType.name,
        this.inputAction = TextInputAction.next,
        this.secure = false})
      : super(key: key);

  final IconData icon;
  final String hint;
  final String? label;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool secure;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
            decoration: InputDecoration(
                labelText: label,
                prefixIcon: Icon(icon),
                hintText: hint
            ),
            obscureText: secure));
  }
}