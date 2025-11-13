import 'package:flutter/material.dart';

import 'PageDoor.dart';
import 'PageMap.dart';
import 'MapaWidget.dart';
import 'package:latlong2/latlong.dart';

class PageSystem extends StatelessWidget {
  final LatLng pos = new LatLng(-33.0, -74.0);

  PageSystem();

  @override
  Widget build(BuildContext context) {
    //LatLng pos = new LatLng( -33.0, -74.0 );
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        PageDoor('Conserjeria', 'Puerta Entrada Peatonal'),
        SizedBox(
          height: 10,
        ),
        PageDoor('Conserjeria', 'Porton Vehicular Superficie'),
        SizedBox(
          height: 5,
        ),
        MapaWidget(
            ubicacion: pos,
            titulo: 'Mapa',
            subTitulo: 'Condominio',
            height: 250.0,
            zoom: 10.0),
        SizedBox(
          height: 10,
        ),
        PageMap(),
      ],
    );
  }
}
