import 'package:flutter/material.dart';
import 'package:notes_app/model/NoteCategory.dart';
import 'package:notes_app/pages/CategoryDropdownButton.dart';
import 'package:notes_app/pages/NotePage.dart';
import 'package:notes_app/uitility/ui_utility/UiUtility.dart';
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

  NoteCategory _selectedNoteCategory;

  @override
  void initState() {
    super.initState();

    if (noteList == null) {
      noteList = List<Note>();
      updateListView(-1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          getCategoryRow(),
          getGridViewFlexible(),
        ],
      ),
    ));
  }

  getCategoryRow(){

    return Row(
      children: <Widget>[
        getCategoryDropdownButton(),
        getClearCategoryButton(),
      ],
    );
  }

  getCategoryDropdownButton() {

    return Container(
        alignment: Alignment.topCenter,
        child: DropdownButton<NoteCategory>(
            hint: Text("Select Category"),
            value: _selectedNoteCategory,
            onChanged:(NoteCategory noteCategory){categoryDropdownOnChanged(noteCategory);},
            items:CategoryDropdownButton.getCategoryDropdownButtonItems(context, 100))
    );
  }

  categoryDropdownOnChanged(noteCategory){
    updateListView(noteCategory.number);
    setState(() {
      _selectedNoteCategory = noteCategory;
    });

  }

  getClearCategoryButton(){

    return IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        updateListView(-1);

        setState(() {
          _selectedNoteCategory = null;
        });
      }
      ,
    );
  }

  getGridViewFlexible() {
    return Flexible(
      child: getGridView(),
    );
  }

  GridView getGridView() {
    var gridViewCount = this.noteList.length;

    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(gridViewCount, (index) {
        return getNoteGestureDetector(index);
      }),
    );
  }

  GestureDetector getNoteGestureDetector(index) {
    return GestureDetector(
      onTap: () {
        navigateToNote(noteList[index]);
      },
      onLongPress: () {
        _deleteNote(index);
      },
      child: getNoteCard(index),
    );
  }

  getNoteCard(index) {
    return Card(
        child: Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(4.0),
      child: getNoteColumn(index),
    ));
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

  getTitle(index) {
    return Container(
        padding: EdgeInsets.all(6.0),
        alignment: Alignment.topLeft,
        child: Text(
          noteList[index].title,
          style: Theme.of(context).textTheme.subtitle,
          maxLines: 1,
        ));
  }

  getNote(index) {
    return Container(
        padding: EdgeInsets.all(4.0),
        alignment: Alignment.centerLeft,
        child: Text(
          noteList[index].content,
          style: Theme.of(context).textTheme.body2,
          maxLines: 5,
        ));
  }

  Container getRow(index) {
    return Container(
        padding: EdgeInsets.only(bottom: 2.0, left: 6.0),
        alignment: Alignment.topRight,
        child: Row(children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: getDate(index),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: NoteCategory.getCategoryIcon(noteList[index].category),

          ),
        ]));
  }

  Text getDate(index) {
    return Text(getDateString(noteList[index].date));
  }

  String getDateString(String strDate) {
    return strDate.substring(0, strDate.indexOf(' '));
  }

  void updateListView(categoryNumber) {
    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = helper.getNoteList(categoryNumber);
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
        });
      });
    });
  }

  void navigateToNote(Note note) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NotePage(note);
    }));
  }

  void _deleteNote(int position) async {
    int result = await helper.deleteNote(noteList[position].id);
    if (result != 0) {
      updateListView(-1);
      UiUtility.showAlertDialog('Status', 'Note Deleted Successfully', context);
    } else {
      UiUtility.showAlertDialog(
          'Status', 'Error Occured while Deleting Note', context);
    }
  }
}
