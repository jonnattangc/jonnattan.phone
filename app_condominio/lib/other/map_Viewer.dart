import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapaWidget extends StatefulWidget 
{
  final LatLng ubicacion;
  final String titulo;
  final String subTitulo;
  final double height;
  final double zoom;

  MapaWidget({@required this.ubicacion, this.titulo, this.subTitulo, this.height = 300.0, this.zoom = 5});

  @override
  _MapaWidgetState createState() => _MapaWidgetState();
}

class _MapaWidgetState extends State<MapaWidget> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Container (
      padding: EdgeInsets.all(7.0),
      /*decoration: BoxDecoration (
        color: Color.fromRGBO(0x99, 0x66, 0x30, 0.4),
        borderRadius: BorderRadius.circular(20.0), 
        boxShadow: <BoxShadow>[
          BoxShadow(blurRadius: 1, spreadRadius: 1.0,offset: Offset(2.0, 1.0))
        ]
      ),*/
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0) ,
        child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          child: FlutterMap( 
                options: MapOptions( center: widget.ubicacion, zoom: widget.zoom), 
                layers: [ _crearMapa(), _crearMarcadores(), ], 
              ),
      ),)
    );
  }

  _crearMapa() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken': 'pk.eyJ1Ijoiam9ubmF0dGFuIiwiYSI6ImNrMzdscm4xeDAwNDAzbmx1dWN5ZTY4MGcifQ.91yKbEmiPA2-N2agHvdNvw',
          'id': 'mapbox.streets' // streets, dark, light, outdoors, satellite
        });
  }

  _crearMarcadores() {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
            anchorPos: AnchorPos.exactly(Anchor(50.0, 30.0)),
            width: 100.0,
            height: 60.0,
            point: widget.ubicacion,
            builder: (context) => Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _creaIcono(),
                      _creaTitulo(),
                      _creaSubTitulo(),
                    ],
                  ),
                )),
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
    if (widget.titulo != null) {
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

    return Container();
  }

  Widget _creaSubTitulo() {
    if (widget.subTitulo != null) 
    {
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
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
