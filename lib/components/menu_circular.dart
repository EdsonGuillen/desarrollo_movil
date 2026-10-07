import 'package:desarrollo_movil/components/global_values.dart';
import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';



class MenuCircular extends StatelessWidget {
  String _colorName = 'No';
  Color _color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return CircularMenu(
        alignment: Alignment.bottomCenter,
          backgroundWidget: Center(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 28),
                children: <TextSpan>[
                  TextSpan(
                    text: _colorName,
                    style:
                        TextStyle(color: _color, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' button is clicked.'),
                ],
              ),
            ),
          ),
          toggleButtonColor: Colors.pink,
          items: [
            CircularMenuItem(
                icon: Icons.light_mode,
                color: Colors.green,
                onTap: () {
                  GlobalValues.banTheme.value = 0;
                }),
            CircularMenuItem(
                icon: Icons.dark_mode,
                color: Colors.blue,
                onTap: () {
                  GlobalValues.banTheme.value = 1;
                }),
            CircularMenuItem(
                icon: Icons.brightness_4,
                color: Colors.orange,
                onTap: () {
                  GlobalValues.banTheme.value = 2;
                }),            
          ],
        );
  }
}