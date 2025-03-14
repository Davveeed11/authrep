import 'dart:collection';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/notes_model.dart';

class NotesProvider extends ChangeNotifier {
  List<NotesModel> _notes = [];

  UnmodifiableListView<NotesModel> get notes => UnmodifiableListView(_notes);

  Future<SharedPreferences> getPrefs() {
    return SharedPreferences.getInstance();
  }

  NotesModel createNotes(String id, String title, String contents) {
    return NotesModel(id: id, title: title, contents: contents);
  }

  Future<void> saveNotes() async {
    final prefs = await getPrefs();
    final notesJson = _notes.map((note) => note.toJson()).toList();
    await prefs.setString('notes', jsonEncode(notesJson));
  }

  Future<void> loadNotes() async {
    final prefs = await getPrefs();
    final notesJson = prefs.getString('notes');

    if (notesJson != null) {
      final decode = jsonDecode(notesJson) as List;
      _notes = decode.map((note) => NotesModel.fromJson(note)).toList();
      notifyListeners();
    }
    //retrieving key and not value
  }

  void addNotes(NotesModel notes) async {
    _notes.add(notes);
    notifyListeners();
    await saveNotes();
  }

  void removeNotes(NotesModel notes) async {
    _notes.remove(notes);
    notifyListeners();
    await saveNotes();
  }

  void updateNotes(NotesModel notes) {
    _notes.remove(notes);
    notifyListeners();
  }
}
