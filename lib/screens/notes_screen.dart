import 'package:desarrollo_movil/database/notes_dao.dart';
import 'package:desarrollo_movil/database/notes_db.dart';
import 'package:flutter/material.dart';


class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late final NotesDB? notesDB;
  late Future<List<NotesDAO>> notesFuture;

  @override
  void initState() {
    super.initState();
    notesDB = NotesDB();
    notesFuture = notesDB!.SELECT();
  }

  void _recargar() {
    setState(() {
      notesFuture = notesDB!.SELECT();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Notas')),
      body: FutureBuilder(
        future: notesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ItemNote(snapshot.data![index]);
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
          Navigator.pushNamed(context, '/add').then((value) => _recargar());
        },
        child: Icon(Icons.note_add_outlined),
      ),
    );
  }

  Widget ItemNote(NotesDAO note) {
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
                  note.title!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(note.content!, style: TextStyle(fontSize: 14)),
              ],
            ),
            IconButton(onPressed: () {
              Navigator.pushNamed(context, '/add', arguments: note);
            }, icon: Icon(Icons.edit)),
            IconButton(
              onPressed: () async {
                return showDialog(
                  context: context,
                  builder: (context) => _buildAlertDialog(note.idNote!),
                );
              },
              icon: Icon(Icons.delete),
            ),            
          ],
        ),
      ),
    );
  }

  Widget _buildAlertDialog(int idNote) {
    return AlertDialog(
      title: Text('Alerta del sistema'),
      content: Text("¿Desea eliminar el registró :) ?"),
      actions: [
        TextButton(
          child: Text("Aceptar"),
          onPressed: () {
            notesDB!.DELETE(idNote).then((value) {
              String msj = (value == 1) ? "Registro borrado" : "Ocurrio un error";
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(msj),
                  duration: Duration(seconds: 3),
                ),
              );
              _recargar();
            });
            Navigator.of(context).pop();
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