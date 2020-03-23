import 'dart:io';
import 'package:flutter/material.dart';
import 'package:notes_app/model/Note.dart';
import 'package:notes_app/model/database_helper.dart';
import 'package:notes_app/pages/NotePage.dart';

class AddNotePage extends StatefulWidget {
  AddNotePage({Key key}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {

  final addNoteInputController = TextEditingController();
  final addNoteTitleInputController = TextEditingController();

  DatabaseHelper helper = DatabaseHelper();
  int count = 0;

  File imageURI;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: addNoteContainer(),
    );
  }

  LayoutBuilder addNoteContainer() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.all(16.0),
            child:  Container(
              height: 400,
              child: Column(
                children: <Widget>[
                  getAddNoteTitleInputTextContainer(),
                  getAddNoteContainInputTextContainer(),
                  addNoteButtonContainer(),
                ],
              ),
            ),
          ));

    });
  }


  Container getAddNoteTitleInputTextContainer(){

    return  getAddNoteInputTextContainer(
        'Add note title', 16.0, 1.5, addNoteTitleInputController, 1);
  }

  Container getAddNoteContainInputTextContainer(){

    return  getAddNoteInputTextContainer(
        'Add a note', 24.0, 2.0, addNoteInputController, 2);
  }



  Container getAddNoteInputTextContainer(
      hint, fontSize, fontHeight, inputController, maxLines) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
        color: Colors.white,
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        width: screenSize.width,
        child: getInputTextField(maxLines, fontSize, fontHeight, hint, inputController),
       );
  }



  TextField getInputTextField(maxLines, fontSize, fontHeight, hint, inputController) {
    return TextField(
      maxLines: maxLines,
      style: new TextStyle(
          fontSize: fontSize, height: fontHeight,
          color: Colors.black
      ),
      decoration: getInputDecoration(hint),
      controller: inputController,
    );
  }

  InputDecoration getInputDecoration(hint) {
    return InputDecoration(border: InputBorder.none, hintText: hint);
  }


  Container addNoteButtonContainer() {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      margin: EdgeInsets.all(16.0),
      child: getAddNoteButton(),
    );
  }

  RaisedButton getAddNoteButton() {
    return  RaisedButton(
      child: getAddNoteButtonText(),
      onPressed: _addNote,
    );
  }

  Text getAddNoteButtonText(){
    return Text('Add', style: new TextStyle(color: Colors.white),);
  }

  void _addNote() async {

    Note note = createNote();
    await helper.insertNote(note);
    navigateToNote(note);
    clearAddNoteInput();

  }

  Note createNote() {
    return new Note(
        addNoteTitleInputController.text, addNoteInputController.text);
  }


  void clearAddNoteInput() {

    addNoteInputController.text = '';
    addNoteTitleInputController.text = '';
  }



  void navigateToNote(Note note) async {

    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NotePage(note);
    }));

  }


}
