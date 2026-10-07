
import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth{
  FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> m_crearUsuario({required String user, required String password}) async{
    try{
      final UserCredential = await  _auth.createUserWithEmailAndPassword(email: user, password: password);
      UserCredential.user!.sendEmailVerification();
    }catch(e) {

    }
  }

Future<void> m_loginUsuario({required String user, required String password}) async{
    try{
      final UserCredential = await  _auth.signInWithEmailAndPassword(email: user, password: password);
      if (UserCredential.user!.emailVerified)
      return true;
        // Usuario verificado, puedes continuar con el inicio de sesión
      } else {
        // Usuario no verificado, muestra un mensaje o realiza alguna acción
      }
    }catch(e) {
      retrun

    }
  }
}
