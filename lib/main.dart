import 'package:desarrollo_movil/components/global_values.dart';
import 'package:desarrollo_movil/components/theme_app.dart';
import 'package:desarrollo_movil/firebase_options.dart';
import 'package:desarrollo_movil/screens/LoginScreen.dart'; // ideal: renombrar a login_screen.dart
import 'package:desarrollo_movil/screens/add_note_screen.dart';
import 'package:desarrollo_movil/screens/dashboard_screen.dart';
import 'package:desarrollo_movil/screens/note_screen.dart';
import 'package:desarrollo_movil/screens/note_screen_cloud.dart';
import 'package:desarrollo_movil/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// Rutas centralizadas para evitar errores de escritura
class AppRoutes {
  static const dash = '/dash';
  static const note = '/note';
  static const add = '/add';
  static const register = '/register';
  static const noteCloud = '/notecloud';
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _getTheme(int value) {
    switch (value) {
      case 1:
        return ThemeData.dark();
      case 2:
        return ThemeApp.warmTheme();
      case 0:
      default:
        return ThemeData.light();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: GlobalValues.banTheme,
      builder: (context, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: _getTheme(value),
          home: const LoginScreen(),
          routes: {
            AppRoutes.dash: (context) => const DashboardScreen(),
            AppRoutes.note: (context) => const NotesScreen(),
            AppRoutes.add: (context) => const AddNoteScreen(),
            AppRoutes.register: (context) => const RegisterScreen(),
            AppRoutes.noteCloud: (context) => const NotesScreenCloud(),
          },
          onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Ruta no encontrada')),
              body: Center(
                child: Text('No existe la ruta: ${settings.name}'),
              ),
            ),
          ),
        );
      },
    );
  }
}