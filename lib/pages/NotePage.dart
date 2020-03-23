import 'package:flutter/material.dart';
import 'package:notes_app/model/Note.dart';
import 'package:notes_app/model/NoteCategory.dart';

class NotePage extends StatefulWidget {
  final Note note;
  NotePage(this.note);

  @override
  _NotePageState createState() => _NotePageState(this.note);
}

class _NotePageState extends State<NotePage> {
  Note note;
  Image image;

  _NotePageState(Note note) {
    this.note = note;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTitle()),
        ),
        body: Container(
            decoration: myBoxDecoration(),
            margin: EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                getRow(),
                getNoteTitleContainer(),
                getNoteContentContainer()
              ],
            )));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Colors.lightBlue[100],
      border: Border.all(color: Colors.lightBlue[100], width: 5.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }


  Container getRow() {
    return Container(
        padding: EdgeInsets.only(bottom:2.0, left: 6.0),
        alignment: Alignment.topRight,
        child: Row(children: [
          getNoteDateContainer(),
         NoteCategory.getCategoryIcon(note.category),
        ]));
  }



  Container getNoteDateContainer() {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(8.0),
      width: screenSize.width-100,
      child: Text(
        getDate(),
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Container getNoteTitleContainer() {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(left: 24.0, right: 24.0),
      width: screenSize.width,
      child: Text(
        getTitle(),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container getNoteContentContainer() {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      margin: EdgeInsets.only(left: 24.0, right: 24.0),
      width: screenSize.width,
      child: Text(
        getNoteContent(),
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  String getDate() {
    return note.date.substring(0, note.date.indexOf(' '));
  }

  String getTitle() {
    if (note != null && note.title != null)
      return note.title;
    return "";
  }

  String getNoteContent() {
    if (note != null && note.content != null) return note.content;
    return "";
  }



}
