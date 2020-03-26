import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class NoteCategory{

  static final List<NoteCategory> noteCategories = <NoteCategory>[
    const NoteCategory(1,Icon(Icons.home,)),
    const NoteCategory(2,Icon(Icons.work,)),
    const NoteCategory(3,Icon(Icons.school,)),
    const NoteCategory(4,Icon(Icons.laptop_chromebook,)),
    const NoteCategory(5,Icon(Icons.schedule,)),
    const NoteCategory(6,Icon(Icons.airplanemode_active, )),
    const NoteCategory(7,Icon(Icons.people, )),
    const NoteCategory(8,Icon(Icons.archive, )),

  ];

  const NoteCategory(this.number,this.icon);
  final int number;
  final Icon icon;


  static getCategoryIcon (categoryNumber){

    switch(categoryNumber){
      case 1 : return Icon(Icons.work, );
      case 2 : return Icon(Icons.home, );
      case 3 : return Icon(Icons.school,);
      case 4 : return Icon(Icons.laptop_chromebook, );
      case 1 : return Icon(Icons.schedule, );
      case 2 : return Icon(Icons.airplanemode_active, );
      case 3 : return Icon(Icons.people,);
      case 4 : return Icon(Icons.archive, );

    }

    return Container();

  }
}