import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PageMap extends StatefulWidget 
{
  @override
  State<StatefulWidget> createState() => _PageMapState();
}

class _PageMapState extends State<PageMap>
{
  @override
  void initState() { 
    super.initState();
    _getUbicacion();
  }

  double latitud = 0.0;
  double longitud = 0.0;

  Completer<GoogleMapController> _controller = Completer();

final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-32.994165, -71.522726),
    zoom: 17.0,
  );

  /*final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/

  @override
    Widget build(BuildContext context) { 
      return 
      ClipRRect(
        borderRadius: BorderRadius.circular(20.0) ,
        child: Card(
        //color: Color.fromRGBO(0x99, 0x66, 0x30, 0.0),
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)), 
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Latitude' + latitud.toString() ),
          Text('Longitude' + longitud.toString() ),
          Container(
            height: 300,
            padding: EdgeInsets.only( top: 0.0, bottom: 2.0, left: 10.0, right: 10.0 ),            
            child: GoogleMap(
              indoorViewEnabled: false,
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) 
              {
                _controller.complete(controller);
              },
            ),
         ),
        ],),
      ),);
    }
    
}

Future<void> _esperarUnRato() async {
  print('Iniciando la espera...');

  // Espera 100 segundos (100000 milisegundos)
  await Future.delayed(Duration(milliseconds: 100000));
  
  // También puedes usar:
  // await Future.delayed(Duration(seconds: 100));

  print('¡Espera terminada! La UI sigue funcionando.');
}

 _getUbicacion( ) async
{
  bool running = true;
  // DateTime lastMsg = DateTime.now();
  print('########## Thread Iniciado');
/*
  var geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  StreamSubscription<Position> positionStream = geolocator.getPositionStream(locationOptions).listen(
    (Position position) {
        print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
    });
*/

  // Solicita el permiso
  var status = await Permission.location.request();

  if (status.isGranted) {
    // El usuario concedió el permiso
    print("Permiso de ubicación concedido.");
  } else if (status.isDenied) {
    // El usuario denegó el permiso una vez
    print("Permiso denegado. Se puede volver a solicitar.");
  } else if (status.isPermanentlyDenied) {
    // El usuario denegó permanentemente y marcó "no volver a preguntar"
    print("Permiso denegado permanentemente. Redirigiendo a la configuración...");
    openAppSettings(); // Función útil para abrir la configuración de la app
  }

  while( running )
  {
    try {
      await _esperarUnRato();
      // print('########## Obtengo Posicion: '  + DateTime.now().toIso8601String() );    
      // var permissions = await Permission.getPermissionsStatus([PermissionName.Calendar, PermissionName.Camera]);
      // print('########## Permiso: '  + permissions[0].permissionName.toString() ); 
      //Permission.openSettings;

      //double distanceInMeters = await Geolocator().distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
      //print('########## Servicio habilitado: ${distanceInMeters.toString()} mts' );
      // Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      //Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
      //if( await geolocator.isLocationServiceEnabled() )
        //print('########## Servicio habilitado: ' );
      //else print('########## Servicio NO habilitado: ');
      /*
        geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        print("Latitude: ${position.latitude} Longitude ${position.longitude} ");
      }).catchError((e) 
      {
        print(e.toString());
      });*/

      //final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
      //Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      // print("Latitude: ${position.latitude} Longitude ${position.longitude} ");
    }catch( error )
    {
      print('########## Error: ' + error.toString() );
      running = false;
      break;
    }
  }    
  print('########## Thread Terminado');
}  
