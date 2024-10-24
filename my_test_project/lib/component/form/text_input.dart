import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {

  final String? initialValue;
  final String hintText;
  final int maxLines;
  final bool expanded;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final Color borderColor;

  const TextInput({
    super.key,
    this.initialValue,
    required this.hintText,
    this.maxLines = 1,
    this.expanded = false,
    this.obscureText = false,
    this.onChanged,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        key: key,
        initialValue: initialValue,
        obscureText: obscureText,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 17),
        textAlign: TextAlign.start,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: hintText,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          fillColor: Colors.white,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
