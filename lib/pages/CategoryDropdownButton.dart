import 'package:flutter/material.dart';
import 'package:notes_app/model/NoteCategory.dart';

class CategoryDropdownButton{


  static getCategoryDropdownButtonItems(context, number) {

    return  NoteCategory.noteCategories.map((NoteCategory noteCategory) {
      return getCategoryDropdownMenuItem(noteCategory, context, number);
    }).toList();

  }

  static DropdownMenuItem<NoteCategory> getCategoryDropdownMenuItem(noteCategory, context, number) {
    final Size screenSize = MediaQuery.of(context).size;

    return DropdownMenuItem<NoteCategory>(
        value: noteCategory,
        child: SizedBox(
          width: screenSize.width - number,
          child: noteCategory.icon,
        )
    );
  }


}