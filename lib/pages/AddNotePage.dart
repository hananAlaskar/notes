import 'package:flutter/material.dart';
import 'package:notes_app/model/Note.dart';
import 'package:notes_app/model/NoteCategory.dart';
import 'package:notes_app/model/database_helper.dart';
import 'package:notes_app/pages/CategoryDropdownButton.dart';
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

  NoteCategory _selectedNoteCategory;

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
        child: Container(
          child: Column(
            children: <Widget>[
              getAddNoteTitleInputTextContainer(),
              getAddNoteContainInputTextContainer(),
              getCategoryRow(),
              addNoteButtonContainer(),
            ],
          ),
        ),
      ));
    });
  }

  Container getAddNoteTitleInputTextContainer() {
    return getAddNoteInputTextContainer(getNoteTitleInputTextField());
  }

  Container getAddNoteContainInputTextContainer() {

    return getAddNoteInputTextContainer(getNoteInputTextField());

  }

  Container getAddNoteInputTextContainer(inputTextField) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      color: Theme.of(context).accentColor,
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      width: screenSize.width,
      child: inputTextField,
    );
  }


  TextField getNoteTitleInputTextField() {
    return TextField(
      maxLines: 1,
      style: Theme.of(context).textTheme.display2,
      decoration: getInputDecoration('Add note title'),
      controller: addNoteTitleInputController,
    );
  }

  TextField getNoteInputTextField() {
    return TextField(
      maxLines: 3,
      style: Theme.of(context).textTheme.display1,
      decoration: getInputDecoration('Add a note'),
      controller: addNoteInputController,
    );
  }


  TextField getInputTextField(
      maxLines, fontSize, fontHeight, hint, inputController) {
    return TextField(
      maxLines: maxLines,
      style: new TextStyle(

          fontSize: fontSize, height: fontHeight, color: Colors.black),
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
    return RaisedButton(
      child: getAddNoteButtonText(),
      onPressed: _addNote,
    );
  }

  Text getAddNoteButtonText() {
    return Text(
      'Add',
      style: Theme.of(context).textTheme.button,

    );
  }

  void _addNote() async {
    Note note = createNote();
    await helper.insertNote(note);
    navigateToNote(note);
    clearAddNoteInput();
  }

  Note createNote() {
    if (_selectedNoteCategory != null)
      return new Note(addNoteTitleInputController.text,
          addNoteInputController.text, _selectedNoteCategory.number);

    return new Note(
        addNoteTitleInputController.text, addNoteInputController.text, -1);
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

  getCategoryRow() {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            getCategoryDropdownButton(),
            getClearCategoryButton(),
          ],
        ));
  }


  getCategoryDropdownButton() {

    return Container(
        alignment: Alignment.topCenter,
        child: DropdownButton<NoteCategory>(
          hint: Text("Select Category"),
          value: _selectedNoteCategory,
          onChanged:(NoteCategory noteCategory){categoryDropdownOnChanged(noteCategory);},
            items:CategoryDropdownButton.getCategoryDropdownButtonItems(context, 140))
    );
  }

  categoryDropdownOnChanged(noteCategory){

      setState(() {
        _selectedNoteCategory = noteCategory;
      });

  }


  getClearCategoryButton() {
    return IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        setState(() {
          _selectedNoteCategory = null;
        });
      },
    );
  }
}
