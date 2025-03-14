import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final bool isSelected;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.isSelected,
    required this.controller,
    this.onChanged,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
 bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: widget.isSelected?IconButton(
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          icon: Icon(
           showPassword ? Icons.visibility : Icons.visibility_off,
          ),
        ):null,
        hintText: widget.hintText,
      ),
      obscureText: widget.isSelected && !showPassword,
    );
  }
}
