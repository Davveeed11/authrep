import 'package:baka/features/core/presentation/utils/round_button_widget.dart';
import 'package:baka/features/notes/data/notesProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/notes_text_feild.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final user =FirebaseAuth.instance.currentUser;
  final TextEditingController title = TextEditingController();
  final TextEditingController contents = TextEditingController();

  void addNotes() {
    if (title.text.isNotEmpty && contents.text.isNotEmpty) {
      final id = user!.uid;
      final newNotes = context.read<NotesProvider>().createNotes(
        id,
        title.text.toUpperCase(),
        contents.text,
      );
      context.read<NotesProvider>().addNotes(newNotes);
      title.clear();
      contents.clear();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('please fill all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => NotesProvider(),
      builder: (context, child) {
        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: addNotes,
              child: Icon(Icons.save),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: .0),
              child: Column(
                spacing: 20,
                children: [
                  SizedBox(height: 10),
                  Row(
                    spacing: 20,
                    children: [
                      RoundbuttonWidget(
                        icons: Icons.arrow_back,
                        ontap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Note View',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  NotesTextFeild(
                    title: 'title',
                    controller: title,
                    maxLines: 1,
                  ),
                  NotesTextFeild(
                    title: 'contents',
                    controller: contents,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
