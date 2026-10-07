import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final txtUser = TextFormField(
      decoration: InputDecoration(
        labelText: 'Usuario',
        border: OutlineInputBorder(),
      ),
    );

    final txtPwd = TextFormField(
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
      onPressed: (){
        isLoading = !isLoading;
        setState(() {});
        Future.delayed(
          Duration (seconds: 4)
          ).then((value) {
            Navigator.pushNamed(context, "/dash");
            isLoading = false;
            setState(() {});
          });
      },
      child: Row(
        children: [
          Icon(Icons.login),
          Text('Iniciar Sesión'),
        ],
      )
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
                  children: [
                    txtUser,
                    Divider(height: 20, color: Colors.transparent),
                    txtPwd,
                    Divider(height: 20, color: Colors.transparent),
                    btnLogin
                  ],
                ),
                height: 230,
                width: MediaQuery.of(context).size.width * 0.5,
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