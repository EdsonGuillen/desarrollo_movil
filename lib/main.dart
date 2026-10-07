import 'package:desarrollo_movil/components/global_values.dart';
import 'package:desarrollo_movil/components/theme_app.dart';
import 'package:desarrollo_movil/firebase_options.dart';
import 'package:desarrollo_movil/screens/LoginScreen.dart';
import 'package:desarrollo_movil/screens/add_note_screen.dart';
import 'package:desarrollo_movil/screens/dashboard_screen.dart';
import 'package:desarrollo_movil/screens/notes_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.banTheme,
      builder: (context,value,_) {

        ThemeData tema = ThemeData.light();
        switch(value){
          case 0: tema = ThemeData.light(); break;
          case 1: tema = ThemeData.dark(); break;
          case 2: tema = ThemeApp.warmTheme();           
        }

        return MaterialApp(
          routes: {
            "/dash" : (context) => DashboardScreen(),
            "/note" :(context) => NotesScreen(),
            "/add" :(context) => AddNoteScreen()
          },
          theme: tema, 
          home: LoginScreen(),
        );
      }
    );
  }
}