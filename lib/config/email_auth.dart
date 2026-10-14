import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Crea el usuario y envía correo de verificación.
  /// Regresa null si todo salió bien, o un mensaje de error.
  Future<String?> m_crearUsuario({
    required String user,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: user,
        password: password,
      );
      await credential.user!.sendEmailVerification();
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Ese correo ya está registrado';
        case 'invalid-email':
          return 'El correo no es válido';
        case 'weak-password':
          return 'La contraseña es muy débil (mínimo 6 caracteres)';
        default:
          return 'Error: ${e.message}';
      }
    } catch (e) {
      return 'Error inesperado: $e';
    }
  }

  /// Regresa null si el login fue correcto, o un mensaje de error.
  Future<String?> m_loginUsuario({
    required String user,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: user,
        password: password,
      );
      if (!credential.user!.emailVerified) {
        await _auth.signOut();
        return 'Verifica tu correo antes de iniciar sesión (revisa tu bandeja y spam)';
      }
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
        case 'user-not-found':
        case 'wrong-password':
          return 'Correo o contraseña incorrectos';
        case 'invalid-email':
          return 'El correo no es válido';
        case 'user-disabled':
          return 'Esta cuenta está deshabilitada';
        case 'too-many-requests':
          return 'Demasiados intentos, intenta más tarde';
        default:
          return 'Error: ${e.message}';
      }
    } catch (e) {
      return 'Error inesperado: $e';
    }
  }
}