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
  bool _isUpdateTitle;
  bool _isUpdateContent;


  Widget _noteTitleWidget;
  Widget _noteContentWidget;

  final _noteTitleInputController = TextEditingController();
  final _noteContentInputController = TextEditingController();

  _NotePageState(Note note) {
    this.note = note;

    _isUpdateTitle = false;
    _isUpdateContent = false;

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

    setNoteTitleWidget();

    return Container(
        decoration: myBoxDecoration(),
        margin: EdgeInsets.all(24.0),
        child: getNoteColumn());
  }

  setNoteTitleWidget(){
    _noteTitleWidget = getNoteTitleContainerChild();
    _noteContentWidget = getNoteContentContainerChild();
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Theme.of(context).cardColor,
      border: Border.all(color: Theme.of(context).cardColor, width: 5.0),
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
      if (_isUpdateTitle == null || _isUpdateTitle == false)
        startUpdatingNoteTitle();
      else
        finisUpdatingNoteTitle();
      _noteTitleWidget = getNoteTitleContainerChild();
    });
  }

  startUpdatingNoteTitle() {
    _isUpdateTitle = true;
    _noteTitleInputController.text = note.title;
  }

  finisUpdatingNoteTitle() {
    _isUpdateTitle = false;
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
    if (_isUpdateTitle == true)
      return TextField(
        controller: _noteTitleInputController,
      );

    return Text(
      note.title,
      style: Theme.of(context).textTheme.title,

    );
  }

  getNoteContentGestureDetector() {
    return GestureDetector(
      onDoubleTap: () {
        updateNoteContent();
      },
      child: getNoteContentContainer(),
    );
  }

  updateNoteContent() {
    setState(() {
      if (_isUpdateContent == null || _isUpdateContent == false)
        startUpdatingNoteContent();
      else
        finisUpdatingNoteContent();
      _noteContentWidget = getNoteContentContainerChild();
    });
  }

  startUpdatingNoteContent() {
    _isUpdateContent = true;
    _noteContentInputController.text = note.content;
  }

  finisUpdatingNoteContent() {
    _isUpdateContent = false;
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
    if (_isUpdateContent == true)
      return TextField(
        controller: _noteContentInputController,
        maxLines: 6,
      );

    return Text(
      note.content,
      style: Theme.of(context).textTheme.body1,
    );
  }

  String getDate() {
    return note.date.substring(0, note.date.indexOf(' '));
  }

  void updateNote(Note note) async {
    await helper.updateNote(note);
  }
}
