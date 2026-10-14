import 'package:desarrollo_movil/config/email_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _userCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _auth = EmailAuth();

  @override
  void dispose() {
    _userCtrl.dispose();
    _pwdCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _userCtrl.text.trim();
    final pwd = _pwdCtrl.text;

    if (email.isEmpty || pwd.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Escribe tu correo y contraseña')),
      );
      return;
    }

    setState(() => isLoading = true);
    final error = await _auth.m_loginUsuario(user: email, password: pwd);
    if (!mounted) return;
    setState(() => isLoading = false);

    if (error == null) {
      Navigator.pushNamed(context, "/dash");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtUser = TextFormField(
      controller: _userCtrl,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Correo electrónico',
        border: OutlineInputBorder(),
      ),
    );

    final txtPwd = TextFormField(
      controller: _pwdCtrl,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        border: OutlineInputBorder(),
      ),
      obscureText: true,
    );

    final loading = Positioned(
      top: 100,
      child: CircularProgressIndicator(color: Colors.white),
    );

    final btnLogin = ElevatedButton(
      onPressed: isLoading ? null : _login,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.login),
          SizedBox(width: 8),
          Text('Iniciar Sesión'),
        ],
      ),
    );

    final btnRegister = TextButton(
      onPressed: () => Navigator.pushNamed(context, "/register"),
      child: Text('¿No tienes cuenta? Regístrate'),
    );

    final space = Container(height: 5,);
    final space2 = SizedBox(height: 5,);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/batman-screen.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('asset/batman-logo.webp', height: 120, width: 120),
            Positioned(
              bottom: 90,
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    txtUser,
                    Divider(height: 20, color: Colors.transparent),
                    txtPwd,
                    Divider(height: 20, color: Colors.transparent),
                    btnLogin,
                    btnRegister,
                  ],
                ),
                                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            isLoading ? loading : Container(),
          ],
        ),
      ),
    );
  }
}