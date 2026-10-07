class NotesDAO {
  int? idNote;
  String? title;
  String? content;
  String? dataNote;

  NotesDAO({this.idNote, this.title, this.content, this.dataNote});

  factory NotesDAO.fromMap(Map<String,dynamic> note){
    return NotesDAO(
      idNote: note['idNote'],
      title: note['title'],
      content: note['content'],
      dataNote: note['dataNote']
    );
  }

}