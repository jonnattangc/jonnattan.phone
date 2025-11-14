import 'package:flutter/material.dart';

import 'PageDoor.dart';
import 'MapaWidget.dart';

class PageSystem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 10,),
        PageDoor('Conserjeria', 'Puerta Entrada Peatonal'),
        SizedBox(height: 10,),
        PageDoor('Conserjeria', 'Porton Vehicular Superficie'),
        SizedBox(height: 5,),
        MapaWidget(),
      ],
    );
  }
}
