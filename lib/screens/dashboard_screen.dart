import 'package:desarrollo_movil/components/menu_circular.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
        ),
        endDrawer: Drawer(
          child: Column(
            children: [
               UserAccountsDrawerHeader(
                accountName: Text("Sebastian Guillen"),
                accountEmail: Text("sebas.guillen@itcelaya.edu.mx"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("asset/image-profile.jpg"),
                ),
               ),
               ListTile(
                title: Text("Practica 1"),
                subtitle: Text("App de práctica"),
                leading: Icon(Icons.youtube_searched_for),
                trailing: Icon(Icons.chevron_right),
               ),
               ListTile(
                title: Text("Lista de Notas"),
                subtitle: Text("App Notes"),
                leading: Icon(Icons.note),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.pushNamed(context, "/note");
                },
               ),
               ListTile(
                title: Text("Cerrar Sesión"),
                subtitle: Text("salir de la aplicación"),
                leading: Icon(Icons.logout),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  //Navigator.pop(context);
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/');
                  //Navigator.popUntil(context, ModalRoute.withName('/login'));
                },
               )
          ],
        ),
      ),    
      floatingActionButton: MenuCircular(),
    );
  }
}