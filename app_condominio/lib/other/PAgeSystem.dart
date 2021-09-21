import 'package:flutter/material.dart';

import 'PageDoor.dart';
import 'PageMap.dart';

class PageSystem extends StatelessWidget
{
  final String imei;
  PageSystem( {@required this.imei});
  
   @override
  Widget build(BuildContext context) 
  {
    //LatLng pos = new LatLng( -33.0, -74.0 );
    return ListView(
      children: <Widget>[
      SizedBox(height: 10,),
      PageDoor('Conserjeria', 'Puerta Entrada Peatonal'),
      SizedBox(height: 10,),
      PageDoor('Conserjeria', 'Porton Vehicular Superficie'),          
      SizedBox(height: 5,),
      //MapaWidget( ubicacion: pos, height: 250.0, zoom: 10.0 ),
      //SizedBox(height: 10,),
      PageMap(),
    ],
  );
  }
}