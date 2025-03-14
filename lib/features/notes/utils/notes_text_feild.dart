import 'package:flutter/material.dart';

class NotesTextFeild extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final int maxLines;

  const NotesTextFeild({
    super.key,
    required this.title,
    required this.controller,
    required this.maxLines,
  });

  @override
  State<NotesTextFeild> createState() => _NotesTextFeildState();
}

class _NotesTextFeildState extends State<NotesTextFeild> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.words,
      maxLines: widget.maxLines,autocorrect: true,
      decoration: InputDecoration(
        hintText: widget.title,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      controller: widget.controller,
    );
  }
}
