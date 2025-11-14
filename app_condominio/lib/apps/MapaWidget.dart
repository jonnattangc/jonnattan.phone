import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:app_condominio/apps/utils/GeoPosUtil.dart';
class MapaWidget extends StatefulWidget {
  const MapaWidget({super.key});

  @override
  State<MapaWidget> createState() => _MapaWidgetState();
}

class _MapaWidgetState extends State<MapaWidget> {
  late final CameraOptions _initialCameraOptions;
  late final String _accessToken;

  void initState() {
    super.initState();
    _accessToken = dotenv.env['MAP_BOX_KEY'] ?? 'none';
    WidgetsFlutterBinding.ensureInitialized();
    MapboxOptions.setAccessToken(_accessToken);
    _initialCameraOptions = _createCameraOptions();
  }

  CameraOptions _createCameraOptions() {
    return CameraOptions(
      center: Point(coordinates: _onMapPosition()),
      zoom: 5,
      bearing: 0,
      pitch: 0,
    );
  }

  Position _onMapPosition() {
    GeoMapUtil geo_util = GeoMapUtil();
    Position? pos =  geo_util.currentPos;
    print("======================>>>>> Posicion: $pos");
    return pos ?? Position(-74.5, 32.5);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: MapWidget(
        key: const ValueKey("mapWidget"),
        cameraOptions: _initialCameraOptions,
        onMapCreated: (MapboxMap mapboxMap) {
          debugPrint("Mapa creado. Token usada: $_accessToken");
        },
      ),
    );
  }
}
