import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class PageMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageMapState();
}

class _PageMapState extends State<PageMap> {
  @override
  void initState() {
    super.initState();
    _getUbicacion();
  }

  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-32.994165, -71.522726),
    zoom: 17.0,
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Card(
        color: Color.fromRGBO(0x99, 0x66, 0x30, 0.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Latitude'),
            Text('Longitude'),
            Container(
              height: 300,
              padding: EdgeInsets.only(
                  top: 0.0, bottom: 2.0, left: 10.0, right: 10.0),
              child: GoogleMap(
                indoorViewEnabled: false,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  _centerMapOnCurrentLocation(controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _centerMapOnCurrentLocation( GoogleMapController mapController) async {
    Position? currentPosition = await _getUbicacion();
    print("Current Position view: ${currentPosition?.latitude}, ${currentPosition?.longitude} ");
    if (currentPosition != null) {
      LatLng currentLatLng = LatLng(currentPosition.latitude, currentPosition.longitude);
      CameraPosition currentCameraPosition = CameraPosition(
        target: currentLatLng,
        zoom: 17, // Un zoom más cercano para ver dónde estás parado
      );
      mapController.animateCamera( CameraUpdate.newCameraPosition(currentCameraPosition),);
    } else {
      // Manejar el caso en que no se pueda obtener la ubicación
      print("No se pudo obtener la ubicación para centrar el mapa.");
    }
  }

  Future<Position?> _getUbicacion() async {
    // Solicita el permiso
    var status = await Permission.location.request();
    if (status.isGranted) {
      print("Permiso de ubicación concedido.");
    } else if (status.isDenied) {
      print("Permiso denegado. Se puede volver a solicitar.");
    } else if (status.isPermanentlyDenied) {
      print(
          "Permiso denegado permanentemente. Redirigiendo a la configuración...");
      openAppSettings(); // Función útil para abrir la configuración de la app
    }

    Position? position = await _getCurrentLocation();
    print( "Latitud: ${position?.latitude} Longitud: ${position?.longitude}");
    return position;
  }

  Future<Position?> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Verificar si el servicio de ubicación está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Los servicios de ubicación no están habilitados.
      return Future.error('Los servicios de ubicación están deshabilitados.');
    }

    // 2. Verificar el estado de los permisos
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Solicitar permisos al usuario si son denegados
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Los permisos de ubicación fueron denegados.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Los permisos están permanentemente denegados.
      return Future.error(
          'Los permisos de ubicación están permanentemente denegados, no podemos solicitar permisos.');
    }

    // 3. Obtener la posición actual del dispositivo
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high, // Alta precisión
        // Opcional: usar un timeout para evitar esperas infinitas
        timeLimit: const Duration(seconds: 10),
      );
      return position;
    } catch (e) {
      print("Error al obtener la ubicación: $e");
      return null;
    }
  }
}
