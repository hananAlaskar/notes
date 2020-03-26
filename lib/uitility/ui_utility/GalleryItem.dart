class NoteImage {

  NoteImage({this.id, this.resource});

  final String id;
  final String resource;


  static List<NoteImage> noteImages = <NoteImage>[
    NoteImage(
      id: "tag1",
      resource: "data_rep/img/note.jpg",
    ),
    NoteImage(
      id: "tag2",
      resource: "data_rep/img/download.jpeg",
    ),
  ];
}
