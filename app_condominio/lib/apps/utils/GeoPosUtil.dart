import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class GeoMapUtil {

  Position? _currentPos;
  
  get currentPos => _currentPos;

  Future<LatLng> getGeoPos() async {
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

    _currentPos = await _getCurrentLocation();

    double lat = _currentPos?.latitude ?? 0.0;
    double lon = _currentPos?.longitude ?? 0.0;
    print("Latitud: ${lat} Longitud: ${lon}");
    return LatLng(lat, lon);
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
