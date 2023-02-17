import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'DaoQuestion.dart';
import 'DataUser.dart';
import 'PageLoading.dart';
import 'PageSystem.dart';
import 'RegisterPage.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 5.0,
        title: Text(this.title),
        actions: <Widget>[
          _crearBotonLogout(context),
        ],
        leading: CircleAvatar(
          backgroundColor: Color.fromRGBO(0x99, 0x66, 0x30, 0.4),
          child: Image(
            image: AssetImage('assets/Logo_Fondo_Transparente.png'),
            height: 50.0,
          ),
        ),
        // bottom: PreferredSizeWidget( ),
        //
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Llamar a Condominio',
        child: Icon(
          Icons.call,
          semanticLabel: 'CALL',
        ),
        elevation: 5.0,
        // foregroundColor: Colors.white70,
        onPressed: () {
          _callCondominio();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 10.0,
        shape: const CircularNotchedRectangle(),
        color: Color.fromRGBO(0x99, 0x66, 0x30, 1.0),
        child: Container(
          height: 40.0,
          child: Center(
              child: Text(
            '${DataUser.getInstance().toString()}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white60),
          )),
        ),
        // elevation: 5.0,
        notchMargin: 5.0,
        clipBehavior: Clip.antiAlias,
      ),
      body: Container(
          // Color de fondo de todo
          color: Color.fromRGBO(0x99, 0x66, 0x30, 0.4),
          child: _getPrincipal(context) //
          ),
    );
  }

  _getPrincipal(BuildContext contex) {
    return FutureBuilder(
      future: _validateImei(),
      initialData: false,
      builder: (BuildContext contex, AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("none");
          case ConnectionState.active:
            return Text("active");
          case ConnectionState.waiting:
            return PageLoading();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return PageError(errorText: snapshot.error.toString());
            } else {
              String imei = DataUser.getInstance().getImei();
              return snapshot.data
                  ? PageSystem(
                      imei: imei,
                    )
                  : RegisterPage(
                      imei: imei,
                    );
            }
        }
        return null; // unreachable
      },
    );
  }

  Future<String> _obtieneImei() async {
    String getimei =
        await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
    print('########## MI IMEI: ' + getimei);
    return getimei;
  }

  Future<bool> _validateImei() async {
    String imei = await _obtieneImei();
    DataUser.getInstance().setIMEI(imei);
    String path = 'validate/' + imei;
    print('########## INTENTO VALIDAR IMEI: ' + imei);
    //valido el IMEI con aquellos que tengo guardados
    try {
      final url = Uri.http("190.100.132.139:8080", path);
      final resp = await http.get(url);
      print('##################### Respuesta: ' + resp.statusCode.toString());
      if (resp.statusCode == 200) {
        final decodeData = json.decode(resp.body);
        final dao = DaoQuestion.fromJsonMap(decodeData);
        print('##################### Respuesta: ' + dao.toString());
        DataUser.getInstance().imeiValid();
        DataUser.getInstance().setDao(dao);
      }
    } catch (error) {
      print('##################### Cath');
    }
    return DataUser.getInstance().isValid();
  }

  _callCondominio() async {
    const url = 'tel:+56323184623';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _crearBotonLogout(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: IconButton(
        icon: Icon(Icons.exit_to_app),
        color: Colors.red /*Color.fromRGBO(0x99, 0x66, 0x30, 0.1)*/,
        onPressed: () => _cierreApp(context),
      ),
    );
  }

  Future<bool> _cierreApp(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: _getBuilder,
    );
  }

  _getBuilder(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Center(
        child: Text(
          'Salir',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      content: _getListView(context),
    );
  }

  Widget _getListView(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Center(child: Text('¿Deseas Salir de Atlántico?')),
          Container(
            padding: EdgeInsets.only(top: 30.0, left: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: ElevatedButton(
                    child: Container(
                      child: Text('Cancelar'),
                    ),
                    //shape: RoundedRectangleBorder(
                    //    borderRadius: BorderRadius.circular(10.0)),
                    //elevation: 0.0,
                    //color: Theme.of(context).primaryColor,
                    //textColor: Colors.white,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Container(
                  width: 100.0,
                  child: ElevatedButton(
                    child: Container(
                      child: Text('Salir'),
                    ),
                    //shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
                    //elevation: 0.0,
                    //color: Theme.of(context).primaryColor,
                    //textColor: Colors.white,
                    onPressed: () => SystemChannels.platform
                        .invokeMethod('SystemNavigator.pop'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
