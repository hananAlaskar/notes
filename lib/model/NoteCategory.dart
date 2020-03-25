import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class NoteCategory{

  static final List<NoteCategory> noteCategories = <NoteCategory>[
    const NoteCategory(1, Icon(Icons.work,)),
    const NoteCategory(2,Icon(Icons.home,)),
    const NoteCategory(3,Icon(Icons.airplanemode_active, )),
    const NoteCategory(4,Icon(Icons.child_care, )),
    const NoteCategory(5,Icon(Icons.archive, )),

  ];

  const NoteCategory(this.number,this.icon);
  final int number;
  final Icon icon;


  static getCategoryIcon (categoryNumber){

    switch(categoryNumber){
      case 1 : return Icon(Icons.work, );
      case 2 : return Icon(Icons.home, );
      case 3 : return Icon(Icons.airplanemode_active,);
      case 4 : return Icon(Icons.child_care, );
      case 0 : return Icon(Icons.archive, );
    }

    return Container();

  }
}