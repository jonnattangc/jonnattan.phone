import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:Atlantico/other/DataUser.dart';
import 'DaoDoor.dart';

class PageDoor extends StatefulWidget
{
  final String nombre;
  final String detalle;
  
  PageDoor( this.nombre, this.detalle );

  @override
  _PageDoorState createState() => _PageDoorState(  );
}

class _PageDoorState extends State<PageDoor>
{
  _PageDoorState( );

  bool abierta = false;

  @override
  Widget build(BuildContext context) { return _cardTarea(); }

  Widget _cardTarea() {
    return  Container(
      padding: EdgeInsets.only( top: 0.0, bottom: 2.0, left: 5.0, right: 5.0 ),
      height: 100.0,
      // width: 205.0,
      child: Card( elevation: 0.0,
                   color: Color.fromRGBO(0x99, 0x66, 0x30, 0.1),
                   shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)), 
                   child: _creaPuerta() ),
    );
  }

  _creaPuerta( )
  {   
    return ListTile (
        dense: true,
        enabled: true, 
        leading: Icon( Icons.account_balance, color: abierta?Colors.green:Colors.red ),
        trailing: Icon(Icons.keyboard_arrow_right),
        title: Text(widget.detalle, style: TextStyle(fontWeight: abierta?FontWeight.bold:FontWeight.normal, fontSize: abierta?16:14, ) ),
        subtitle: Text(abierta?'Puerta Abierta':'Puerta Cerrada' , style: TextStyle(fontWeight: FontWeight.bold, fontSize: abierta?14:12, )), 
        onLongPress: _press,
        onTap: (){},
      );
  }

  _press() async
  {
    String myimei = DataUser.getInstance().getImei();
    DaoDoor dao = new DaoDoor( imei:myimei, iddoor: widget.nombre );
    print('##################### DOOR: ' + dao.toString());
    try{
      final url = Uri.http("190.100.132.139:8080", "open");
      final resp = await http.post( url, 
        headers: { HttpHeaders.contentTypeHeader:'application/json'},
        body: json.encode( dao.toJsonMap() ) );
      print('##################### Respuesta: ' + resp.statusCode.toString());
      if( resp.statusCode == 200 ) //200 es CREADO
      {
        final decodeData = json.decode(resp.body);    
        print('##################### Respuesta: ' + decodeData.toString() );
        abierta = decodeData;
      }
    }catch( error)
    {
      print('##################### Cath');
      abierta = false;
    }
    setState(() 
    {
      if( abierta )
      {
         print("############## Abre Puerta");
         //_openDoor();
      }
    });
  }
  
  Future<void> _openDoor() async
  {
     print("Ejecuta servicio para abrir...");
     showDialog( 
      context: context,
      builder: (context)  {
       return AlertDialog( title: Text('Puerta'),
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
         content: Column(
         mainAxisSize: MainAxisSize.min,
         children: <Widget>[
           Text( 'Abre Puerta' ),
           Image(image: AssetImage('assets/Logo_Fondo_Transparente.png'), height: 30.0,),           
         ],
       ),
       actions: <Widget>[
         FlatButton( child: Text('Cancelar'), onPressed: ()=> Navigator.of(context).pop(),),
         FlatButton( child: Text('Ok'), onPressed: _openDoor,),
       ],
      );
      } 
    );
  }
}