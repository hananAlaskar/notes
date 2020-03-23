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
        body: getGridView()
    );
  }

  GridView getGridView() {
    var gridViewCount = this.noteList.length;

    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(gridViewCount, (index) {
        return getNoteContainer(index);
      }),
    );
  }

  Container getNoteContainer(index) {
    return new Container(
      child: Card(
          child: Container(
        margin: EdgeInsets.all(4.0),
        padding: EdgeInsets.all(4.0),
        child: getNoteColumn(index),
      )),
    );
  }

  Column getNoteColumn(index) {
    return Column(
      children: <Widget>[
        getRow(index),
        getTitle(index),
        getNote(index),
      ],
    );
  }

  Flexible getTitle(index) {
    return Flexible(
        fit: FlexFit.tight,
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(4.0),
            alignment: Alignment.topCenter,
            child: Text(
              noteList[index].title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            )));
  }

  Flexible getNote(index) {
    return Flexible(
        fit: FlexFit.tight,
        flex: 1,
        child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              noteList[index].content,
              style: TextStyle(
                fontSize: 12,
              ),
              maxLines: 2,
            )));
  }

  Container getRow(index) {
    return Container(
        padding: EdgeInsets.only(bottom:2.0),
        alignment: Alignment.topCenter,
        child: Row(children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Icon(Icons.note, size: 15,),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 4,
            child: getDate(index),
          ),
        ]));
  }

  Text getDate(index) {
    return Text(getDateString(noteList[index].date));
  }

  String getDateString(String strDate) {
    return strDate.substring(0, strDate.indexOf(' '));
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
