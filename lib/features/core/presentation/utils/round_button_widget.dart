import 'package:flutter/material.dart';

class RoundbuttonWidget extends StatefulWidget {
  final Function()? ontap;
  final IconData icons;
   Color? colors;



   RoundbuttonWidget({super.key, required this.icons, this.ontap, this.colors =Colors.grey});

  @override
  State<RoundbuttonWidget> createState() => _RoundbuttonWidgetState();
}

class _RoundbuttonWidgetState extends State<RoundbuttonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        height: 47,
        width: 47,
        decoration: BoxDecoration(
          color: widget.colors,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(child: Icon(widget.icons, color: Colors.white)),
      ),
    );
  }
}
