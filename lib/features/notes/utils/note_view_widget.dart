import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteViewWidget extends StatefulWidget {
  final Function()? ontap;
  final String title;
  final String content;

  const NoteViewWidget({
    super.key,
    this.ontap,
    required this.title,
    required this.content,
  });

  @override
  State<NoteViewWidget> createState() => _NoteViewWidgetState();
}

class _NoteViewWidgetState extends State<NoteViewWidget> {
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.sizeOf(context);
    return InkWell(
      onTap: widget.ontap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        width: size.width/6,
        decoration: BoxDecoration(color: CupertinoColors.systemYellow),
        child: Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 6),
            Text(
              widget.content,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
