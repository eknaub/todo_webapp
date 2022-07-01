import 'package:todo_webapp/sharedPrefs/prefs.dart';

import 'note.dart';

class NoteList {
  final List<Note> _notes = [];

  NoteList() {
    var list = sharedPrefs.getAllNotes();
    for (var item in list) {
      _notes.add(Note(note: item));
    }
  }

  List<Note> get notes => _notes;

  int length() => notes.length;

  void removeAt({required int index}) {
    sharedPrefs.removeNoteFromNotes(noteIdx: index);
    _notes.removeAt(index);
  }

  void removeAll() {
    sharedPrefs.removeAllNotes();
    _notes.clear();
  }

  void add({required String note}) {
    _notes.add(Note(note: note));
    sharedPrefs.addNote(note: note);
  }

  String getNoteAt({required int index}) {
    String note = _notes[index].note;
    return note;
  }
}
