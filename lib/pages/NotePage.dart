import 'package:flutter/material.dart';
import 'package:notes_app/model/Note.dart';
import 'package:notes_app/model/NoteCategory.dart';
import 'package:notes_app/model/database_helper.dart';

class NotePage extends StatefulWidget {
  final Note note;
  NotePage(this.note);

  @override
  _NotePageState createState() => _NotePageState(this.note);
}

class _NotePageState extends State<NotePage> {
  DatabaseHelper helper = DatabaseHelper();

  Note note;
  bool _isUpdate;

  Widget _noteTitleWidget;
  Widget _noteContentWidget;

  final _noteTitleInputController = TextEditingController();
  final _noteContentInputController = TextEditingController();

  _NotePageState(Note note) {
    this.note = note;
    _isUpdate = false;

    _noteTitleWidget = getNoteTitleContainerChild();
    _noteContentWidget = getNoteContentContainerChild();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(note.title),
        ),
        body: getNoteBody());
  }

  getNoteBody() {
    return Container(
        decoration: myBoxDecoration(),
        margin: EdgeInsets.all(24.0),
        child: getNoteColumn());
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Colors.lightBlue[100],
      border: Border.all(color: Colors.lightBlue[100], width: 5.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }

  Column getNoteColumn() {
    return Column(
      children: <Widget>[
        getRow(),
        getNoteTitleGestureDetector(),
        getNoteContentGestureDetector()
      ],
    );
  }

  Container getRow() {
    return Container(
        padding: EdgeInsets.only(bottom: 2.0, left: 6.0),
        alignment: Alignment.topRight,
        child: Row(children: [
          getNoteDateContainer(),
          getNoteCategory(),
        ]));
  }

  getNoteCategory() {
    return NoteCategory.getCategoryIcon(note.category);
  }

  Container getNoteDateContainer() {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(8.0),
      width: screenSize.width - 100,
      child: Text(
        getDate(),
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  getNoteTitleGestureDetector() {
    return GestureDetector(
      onDoubleTap: () {
        updateNoteTitle();
      },
      child: getNoteTitleContainer(),
    );
  }

  updateNoteTitle() {
    setState(() {
      if (_isUpdate == null || _isUpdate == false)
        startUpdatingNoteTitle();
      else
        finisUpdatingNoteTitle();
      _noteTitleWidget = getNoteTitleContainerChild();
    });
  }

  startUpdatingNoteTitle() {
    _isUpdate = true;
    _noteTitleInputController.text = note.title;
  }

  finisUpdatingNoteTitle() {
    _isUpdate = false;
    note.title = _noteTitleInputController.text;
    updateNote(note);
  }

  Container getNoteTitleContainer() {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(left: 24.0, right: 24.0),
      width: screenSize.width,
      child: _noteTitleWidget,
    );
  }

  Widget getNoteTitleContainerChild() {
    if (_isUpdate == true)
      return TextField(
        controller: _noteTitleInputController,
      );

    return Text(
      note.title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  getNoteContentGestureDetector() {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          startUpdatingNoteContent();
        });
      },
      child: getNoteContentContainer(),
    );
  }

  updateNoteContent() {
    setState(() {
      if (_isUpdate == null || _isUpdate == false)
        startUpdatingNoteContent();
      else
        finisUpdatingNoteContent();

      _noteContentWidget = getNoteContentContainerChild();
    });
  }

  startUpdatingNoteContent() {
    _isUpdate = true;
    _noteContentInputController.text = note.content;
  }

  finisUpdatingNoteContent() {
    _isUpdate = false;
    note.content = _noteContentInputController.text;
    updateNote(note);
  }

  Container getNoteContentContainer() {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      margin: EdgeInsets.only(left: 24.0, right: 24.0),
      width: screenSize.width,
      child: _noteContentWidget,
    );
  }

  Widget getNoteContentContainerChild() {
    if (_isUpdate == true)
      return TextField(
        controller: _noteContentInputController,
        maxLines: 6,
      );

    return Text(
      note.content,
      style: TextStyle(fontSize: 16.0),
    );
  }

  String getDate() {
    return note.date.substring(0, note.date.indexOf(' '));
  }

  void updateNote(Note note) async {
    await helper.updateNote(note);
  }
}
