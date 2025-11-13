import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'DataUser.dart';
import 'DaoDoor.dart';

class PageDoor extends StatefulWidget {
  final String nombre;
  final String detalle;

  PageDoor(this.nombre, this.detalle);

  @override
  _PageDoorState createState() => _PageDoorState();
}

class _PageDoorState extends State<PageDoor> {
  _PageDoorState();

  bool _open_door = false;

  final String _auth_key = dotenv.env['AUTH_KEY'] ?? 'none';

  @override
  Widget build(BuildContext context) {
    return _cardTarea();
  }

  Widget _cardTarea() {
    return Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 2.0, left: 5.0, right: 5.0),
      height: 100.0,
      child: Card(
          elevation: 0.0,
          color: Color.fromRGBO(0x99, 0x66, 0x30, 0.1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: _creaPuerta()),
    );
  }

  _creaPuerta() {
    return ListTile(
      dense: true,
      enabled: true,
      leading: Icon(_open_door ? Icons.lock_open : Icons.lock_clock_sharp,
          color: _open_door ? Colors.green : Colors.red),
      trailing: Icon(Icons.keyboard_arrow_right),
      title: Text(widget.detalle,
          style: TextStyle(
            fontWeight: _open_door ? FontWeight.bold : FontWeight.normal,
            fontSize: _open_door ? 16 : 20,
          )),
      subtitle: Text(_open_door ? 'Puerta Abierta' : 'Puerta Cerrada',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: _open_door ? 14 : 12,
          )),
      onLongPress: _openDoor,
      onTap: () {},
    );
  }

  Future<void> _openDoor() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Puerta'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Abre Puerta'),
                Image(
                  image: AssetImage('assets/Logo_Fondo_Transparente.png'),
                  height: 30.0,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text('Ok'),
                onPressed: () => {_press(), Navigator.of(context).pop()},
              ),
            ],
          );
        });
  }

  _press() async {
    DataUser? user = DataUser();
    print('##################### DOOR: ' + user.toString());
    print('##################### Name: ' +widget.nombre.toString());
    String imei = user.getImei();
    DaoDoor dao = new DaoDoor(imei: imei, doorId: 0, doorName: widget.nombre, curretState: _open_door);

    final url = Uri.https("api.jonnattan.cl", "/mobile/door/open");
    final Map<String, String> _headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ' + _auth_key,
      'Accept': 'application/json'
    };

    try {
      final http.Response response = await http.post(url,
          headers: _headers, body: json.encode(dao.toJsonMap()));
      print('Respuesta: ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        final data_json = json.decode(response.body);
        print('Respuesta: ' + data_json.toString());
        _open_door = data_json['opened'];
      }
    } catch (error, stackTrace) {
      print('Error: $error Stack $stackTrace');
      _open_door = false;
    }
    setState(() {
      if (_open_door) {
        _cardTarea();
      }
    });
  }
}
