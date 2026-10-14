import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desarrollo_movil/config/firestore_notes.dart';
import 'package:desarrollo_movil/database/notes_dao.dart';
import 'package:desarrollo_movil/database/notes_db.dart';
import 'package:flutter/material.dart';


class NotesScreenCloud extends StatefulWidget {
  const NotesScreenCloud({super.key});

  @override
  State<NotesScreenCloud> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreenCloud> {
  FirestoreNotes? _firestoreNotes;

  @override
  void initState() {
    super.initState();
    _firestoreNotes = FirestoreNotes();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Notas')),
      body: StreamBuilder(
        stream: _firestoreNotes!.m_select(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                return ItemNote(snapshot.data!.docs[index]);
              },
            );
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pushNamed(context, '/add').then((value) => _recargar());
        },
        child: Icon(Icons.note_add_outlined),
      ),
    );
  }

  Widget ItemNote(QueryDocumentSnapshot<Object?> note) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              child: Center(child: Text("10")),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.blue,
              ),
            ),
            Column(
              children: [
                Text(
                  note.get("title!"),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(note.get("content!"), style: TextStyle(fontSize: 14)),
              ],
            ),
            IconButton(onPressed: () {
              Navigator.pushNamed(context, '/add', arguments: note);
            }, icon: Icon(Icons.edit)),
            IconButton(
              onPressed: () async {
                return showDialog(
                  context: context,
                  builder: (context) => _buildAlertDialog(note.id),
                );
              },
              icon: Icon(Icons.delete),
            ),            
          ],
        ),
      ),
    );
  }

  Widget _buildAlertDialog(String idNote) {
    return AlertDialog(
      title: Text('Alerta del sistema'),
      content: Text("¿Desea eliminar el registró :) ?"),
      actions: [
        TextButton(
          child: Text("Aceptar"),
          onPressed: () {
            //notesDB!.DELETE(idNote).then((value) {
              //String msj = (value == 1) ? "Registro borrado" : "Ocurrio un error";
             // ScaffoldMessenger.of(context).showSnackBar(
               // SnackBar(
                 // content: Text(msj),
               //   duration: Duration(seconds: 3),
              //  ),
             // );
             // _recargar();
            //});
            //Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}