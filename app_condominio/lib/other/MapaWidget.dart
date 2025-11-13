import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapaWidget extends StatefulWidget {
  final LatLng ubicacion;
  final String titulo;
  final String subTitulo;
  final double height;
  final double zoom;

  MapaWidget(
      {required this.ubicacion,
      required this.titulo,
      required this.subTitulo,
      required this.height,
      required this.zoom});

  @override
  _MapaWidgetState createState() => _MapaWidgetState( ubicacion );
}

class _MapaWidgetState extends State<MapaWidget> {

  final String _key_map = dotenv.env['MAP_BOX_KEY'] ?? '';
  LatLng _ubicacion = LatLng( -33.0, -74.0 );

  _MapaWidgetState( this._ubicacion );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7.0),
      height: widget.height,
      // El Container le da el tamaño
      child: ClipRRect(
        // Aplicamos el recorte y borde redondeado directamente aquí
        borderRadius: BorderRadius.circular(20.0),
        child: Card(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          child: FlutterMap(
            options: MapOptions(
              initialCenter: _ubicacion,
              initialZoom: 8.0,
            ),
            children: [
              _crearMapa(),
            ],
          ),
        ),
      ),
    );
  }

  _crearMapa() {
    return TileLayer(
        urlTemplate:
            'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token=' + _key_map,
        additionalOptions: {
          'accessToken': _key_map,
          'id': 'mapbox.streets' // streets, dark, light, outdoors, satellite-v9
        });
  }

  /*_crearMarcadores() {
    return MarkerLayer(
      markers: [
        Marker(
          point: LatLng(51.5, -0.1), // Coordenada donde se ubicará el marcador
          width: 80.0,              // Ancho que ocupará el marcador en píxeles
          height: 80.0,             // Alto que ocupará el marcador en píxeles
          // El 'builder' define el widget que se dibujará como el marcador
          builder: (context) => const Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 40.0,
          ),
        ),
        //Marker(
        //  point: posTest,
        //  builder: (context) => Column(
        //      crossAxisAlignment: CrossAxisAlignment.center,
        //      mainAxisAlignment: MainAxisAlignment.start,
        //      children: <Widget>[ _creaIcono(), _creaTitulo(), _creaSubTitulo(), ],
        //  ),
        //),
      ],
    );
  }

  Widget _creaIcono() {
    return Container(
      padding: EdgeInsets.only(right: 8.0),
      child: Icon(Icons.location_on,
          size: 40, color: Theme.of(context).primaryColor),
    );
  }

  Widget _creaTitulo() {
    return Center(
      child: Text(
        widget.titulo, overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 8.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0x78, 0x90, 0x9c, 0.0) ),
      ),
    );
  }

  Widget _creaSubTitulo() {
    return Center(
        child: Text(
          widget.subTitulo, overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0x78, 0x90, 0x9c, 0.0)) 
        ),
      );
  }
*/
  @override
  void dispose() {
    super.dispose();
  }
}
