import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:notes_app/model/Note.dart';
import 'package:notes_app/model/database_helper.dart';

class NoteListPage extends StatefulWidget {
  NoteListPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {

  List<Note> noteList;
  DatabaseHelper helper = DatabaseHelper();
  int count = 0;

  @override
  void initState() {
    super.initState();

    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Note List"),
        ),
        body: getListView()
        );
  }

  getListView() {

    return ListView.builder(
      itemCount: noteList.length,
      itemBuilder: (context, position) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(noteList[position].title, style: TextStyle(fontSize: 22.0),),
          ),
        );
      },
    );
  }


  void updateListView() {
    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = helper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
        });
      });
    });
  }


}
