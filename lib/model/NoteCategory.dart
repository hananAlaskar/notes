import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class NoteCategory{

  static final List<NoteCategory> noteCategories = <NoteCategory>[
    const NoteCategory(1, Icon(Icons.work,color: Colors.lightBlue,)),
    const NoteCategory(2,Icon(Icons.home, color: Colors.lightBlue)),
    const NoteCategory(3,Icon(Icons.airplanemode_active, color: Colors.lightBlue)),
    const NoteCategory(4,Icon(Icons.child_care, color: Colors.lightBlue)),
    const NoteCategory(5,Icon(Icons.archive, color: Colors.lightBlue)),

  ];

  const NoteCategory(this.number,this.icon);
  final int number;
  final Icon icon;


  static getCategoryIcon (categoryNumber){

    switch(categoryNumber){
      case 1 : return Icon(Icons.work, color: Colors.lightBlue[400]);
      case 2 : return Icon(Icons.home, color: Colors.lightBlue[400]);
      case 3 : return Icon(Icons.airplanemode_active, color: Colors.lightBlue[400]);
      case 4 : return Icon(Icons.child_care, color: Colors.lightBlue[400]);
      case 0 : return Icon(Icons.archive, color: Colors.lightBlue[400]);
    }

    return Container();

  }
}