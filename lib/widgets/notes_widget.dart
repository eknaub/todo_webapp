import 'package:flutter/material.dart';
import 'package:todo_webapp/shared_prefs/prefs.dart';

class NotesWidget extends StatefulWidget {
  const NotesWidget({Key? key}) : super(key: key);

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  late TextEditingController _noteController;
  late List<String>? notes = [];

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    notes = sharedPrefs.getAllNotes();
    return Column(
      children: [
        const Center(
          child: Text(
            "Notes",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              label: const Text(
                "New note",
              ),
              icon: const Icon(Icons.add),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Add note'),
                  content: TextField(
                    controller: _noteController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      hintText: "Type something ...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () =>
                          {_noteController.text = '', Navigator.pop(context)},
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueGrey[700])),
                      onPressed: () {
                        sharedPrefs.addNote(note: _noteController.text);
                        _noteController.text = '';
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              icon: const Icon(Icons.delete),
              label: const Text(
                "Remove all notes",
              ),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Remove all notes'),
                  content:
                      const Text('Are you sure you want to remove all notes?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () =>
                          {_noteController.text = '', Navigator.pop(context)},
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      onPressed: () {
                        sharedPrefs.removeAllNotes();
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text('Remove'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: notes?.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              color: Colors.blueGrey[700],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      notes![index],
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      sharedPrefs.removeNoteFromNotes(noteIdx: index);
                      setState(() {});
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.white,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
