import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Function()? ontap;
  final String title;

  const Button({super.key, this.ontap, required this.title});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: widget.ontap,
      style: FilledButton.styleFrom(minimumSize: Size(double.infinity, 50)),
      child: Text(widget.title),
    );
  }
}
