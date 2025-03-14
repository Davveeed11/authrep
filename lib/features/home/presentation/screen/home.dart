import 'package:baka/features/auth/data/auth_repo_impl.dart';
import 'package:baka/features/auth/presentation/manager/auth_provider.dart';
import 'package:baka/features/notes/data/notesProvider.dart';
import 'package:baka/features/notes/utils/note_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../notes/presentation/notes_page.dart';
import '../../../notes/presentation/notes_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthRepoImpl authRepo = AuthRepoImpl();

  @override
  void initState() {
    super.initState();
    Provider.of<NotesProvider>(context, listen: false).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          actions: [
            Consumer<AuthProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'Sign out',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Are you sure?',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Row(
                                spacing: 10,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                          double.infinity,
                                          MediaQuery.of(context).size.height /
                                              16,
                                        ),
                                        backgroundColor: Colors.white24,
                                      ),
                                      child: Text('No'),
                                    ),
                                  ),

                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        provider.signOut();

                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                          double.infinity,
                                          MediaQuery.of(context).size.height /
                                              16,
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                      child: Text('Yes'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.clear, color: Colors.white),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return NotesPage();
                },
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        body: Consumer<NotesProvider>(
          builder: (context, noteProvider, child) {
            return MasonryGridView.builder(
              gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),

              itemCount: noteProvider.notes.length,
              itemBuilder: (context, index) {
                final note = noteProvider.notes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: NoteViewWidget(
                      title: note.title,
                      content: note.contents,
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NotesView(
                                title: note.title,
                                contents: note.contents,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
