import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:notes_app/uitility/ImageUtility.dart';
import 'package:url_launcher/url_launcher.dart';
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

  Note _note;
  Image _noteImage;
  bool _isUpdateTitle;
  bool _isUpdateContent;

  Widget _noteTitleWidget;
  Widget _noteContentWidget;

  final _noteTitleInputController = TextEditingController();
  final _noteContentInputController = TextEditingController();

  _NotePageState(Note note) {
    this._note = note;
    _isUpdateTitle = false;
    _isUpdateContent = false;

    loadImageFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_note.title),
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

  setNoteTitleWidget() {
    _noteTitleWidget = getNoteTitleContainerChild();
    _noteContentWidget = getNoteContentContainerChild();
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Theme
          .of(context)
          .cardColor,
      border: Border.all(color: Theme
          .of(context)
          .cardColor, width: 5.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }

  Column getNoteColumn() {
    return Column(
      children: <Widget>[
        getRow(),
        getNoteTitleGestureDetector(),
        getNoteContentGestureDetector(),
        getNoteImage()
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
    return NoteCategory.getCategoryIcon(_note.category);
  }

  Container getNoteDateContainer() {
    final Size screenSize = MediaQuery
        .of(context)
        .size;

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
    _noteTitleInputController.text = _note.title;
  }

  finisUpdatingNoteTitle() {
    _isUpdateTitle = false;
    _note.title = _noteTitleInputController.text;
    updateNote(_note);
  }

  Container getNoteTitleContainer() {
    final Size screenSize = MediaQuery
        .of(context)
        .size;

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
      _note.title,
      style: Theme
          .of(context)
          .textTheme
          .title,
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
    _noteContentInputController.text = _note.content;
  }

  finisUpdatingNoteContent() {
    _isUpdateContent = false;
    _note.content = _noteContentInputController.text;
    updateNote(_note);
  }

  Container getNoteContentContainer() {
    final Size screenSize = MediaQuery
        .of(context)
        .size;

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

    return Linkify(
      onOpen: (link) {
        lunchLink(link);
      },
      text: _note.content,
      style: Theme
          .of(context)
          .textTheme
          .body1,
    );
  }

  lunchLink(link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch : $link';
    }
  }

  String getDate() {
    return _note.date.substring(0, _note.date.indexOf(' '));
  }

  void updateNote(Note note) async {
    await helper.updateNote(note);
  }

  getNoteImage() {

    return Flexible(
        child:
        Container(
      margin: EdgeInsets.all( 24.0),
      child: null == _noteImage ? Container() : _noteImage,
    ));
  }


  void loadImageFromPreferences() {
    ImageUtility.getImageFromPreferences(_note.id.toString()).then((img) {

      setState(() {
        if (null != img)
        _noteImage = ImageUtility.imageFromBase64String(img);

      });

    });

  }
}


