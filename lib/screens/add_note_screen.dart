import 'package:desarrollo_movil/database/notes_dao.dart';
import 'package:desarrollo_movil/database/notes_db.dart';
import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _conTitle = TextEditingController();
  final _conContent = TextEditingController();

  late final NotesDB _notesDB;
  NotesDAO? _note;
  bool _initialized = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _notesDB = NotesDB();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Se ejecuta una sola vez: carga la nota si viene como argumento
    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is NotesDAO) {
        _note = args;
        _conTitle.text = args.title ?? '';
        _conContent.text = args.content ?? '';
      }
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _conTitle.dispose();
    _conContent.dispose();
    super.dispose();
  }

  String _today() {
    final now = DateTime.now();
    final mm = now.month.toString().padLeft(2, '0');
    final dd = now.day.toString().padLeft(2, '0');
    return '${now.year}-$mm-$dd';
  }

  Future<void> _saveNote() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    try {
      final int result;

      if (_note == null) {
        result = await _notesDB.INSERT({
          'title': _conTitle.text.trim(),
          'content': _conContent.text.trim(),
          'dateNote': _today(),
        });
      } else {
        result = await _notesDB.UPDATE({
          'idNote': _note!.idNote,
          'title': _conTitle.text.trim(),
          'content': _conContent.text.trim(),
        });
      }

      if (!mounted) return;

      if (result > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Se guardó el registro correctamente'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.pop(context);
      } else {
        _showError('No se pudo guardar el registro');
      }
    } catch (e) {
      if (!mounted) return;
      _showError('Error al guardar: $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Nota' : 'Insertar Nota'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _conTitle,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'El título es obligatorio'
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _conContent,
                maxLines: 8,
                decoration: const InputDecoration(
                  labelText: 'Contenido',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'El contenido es obligatorio'
                    : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saving ? null : _saveNote,
                  child: _saving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Guardar nota'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}