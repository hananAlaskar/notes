

class Note {

  int _id;
  String _title;
  String _content;
  String _date;
  int _category;


  Note(title, content, category) {
    this._content = content;
    this._title = title;
    this._category = category;
    this._date = DateTime.now().toString();
  }

  int get id => _id;
  String get content => _content;
  String get date => _date;
  int get category => _category;
  String get title => _title;

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['content'] = _content;
    map['category'] = _category;
    map['date'] = _date;

    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._content = map['content'];
    this._category = map['category'];
    this._date = map['date'];
  }


}
