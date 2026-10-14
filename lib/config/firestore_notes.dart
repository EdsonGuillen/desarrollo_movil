import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreNotes {
  FirebaseFirestore conexion= FirebaseFirestore.instance;
  CollectionReference? notesCollection;

  FirestoreNotes() {
    notesCollection = conexion.collection("notes");
  }
m_insert(Map <String,dynamic> note) async{
  notesCollection!.doc().set(note);
}
m_update(Map <String,dynamic> note,String id) async{
  notesCollection!.doc(id).update(note);
}
m_delete(String id) async{
  notesCollection!.doc(id).delete();
}
Stream<QuerySnapshot> m_select(){
  return notesCollection!.snapshots();
}





}