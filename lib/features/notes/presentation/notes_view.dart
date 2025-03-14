import 'package:flutter/material.dart';

import '../../core/presentation/utils/round_button_widget.dart';

class NotesView extends StatelessWidget {
  final String title;
  final String contents;

  const NotesView({super.key, required this.title, required this.contents});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade100,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Row(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundbuttonWidget(
                        icons: Icons.arrow_back_ios,
                        ontap: () {
                          Navigator.pop(context);
                        },
                        colors: Colors.grey,
                      ),
                      RoundbuttonWidget(icons: Icons.menu),
                    ],
                  ),
                  SizedBox(height: 40),
                  Text(
                    title,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
                  ),
                  Text(contents, style: TextStyle(fontSize: 22,)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
