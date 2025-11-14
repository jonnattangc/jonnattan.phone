import 'package:app_condominio/apps/utils/ImeiUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dao/DaoQuestion.dart';
import 'DataUser.dart';
import 'PageLoading.dart';
import 'PageSystem.dart';
import 'PageRegister.dart';
import 'package:app_condominio/apps/http/Services.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  final String _auth_key = dotenv.env['AUTH_KEY'] ?? 'none';
  final String _phone_number = dotenv.env['PHONE_NUMBER'] ?? '+56';

  MyHomePage({Key? key, required this.title}) : super(key: key);

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
            height: 30.0,
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
        foregroundColor: const Color.fromARGB(61, 255, 255, 255),
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
          height: 20.0,
          child: Center(
              child: Text(
            'Condominio',
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
    return FutureBuilder<DataUser?>(
      future: _imeiValidate(contex),
      initialData: null,
      builder: (BuildContext contex, AsyncSnapshot<DataUser?> snapshot) {
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
              DataUser? data = snapshot.data;
              String imei_str = data?.getImei() ?? "...";
              print('########## IMEI: ${imei_str}');
              Widget page;
              if (data == null) {
                page = new PageRegister();
              } else {
                page = PageSystem();
              }
              return page;
            }
        }
      },
    );
  }

  Future<DataUser?> _imeiValidate(BuildContext contex) async {
    ImeiUtil util = ImeiUtil( context: contex);
    Services services = Services();
    String imei = await util.getImei();
    print('########## IMEI: ${imei}');
    DataUser? user = await services.validateImei( imei );    
    
    return user;
  }

  _callCondominio() async {
    final phoneNumber = 'tel:$_phone_number';
    print('############## Calling: $phoneNumber');
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await launchUrl(launchUri)) {
      print('Successfully launched: $phoneNumber');
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  Widget _crearBotonLogout(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      child: IconButton(
        icon: Icon(Icons.exit_to_app),
        color: const Color.fromARGB(255, 100, 112, 33) /*Color.fromRGBO(0x99, 0x66, 0x30, 0.1)*/,
        onPressed: () => _cierreApp,
      ),
    );
  }

  Future<bool?> _cierreApp(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      builder: _getBuilder,
    );
  }

  Widget _getBuilder(BuildContext context) {
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
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Container(
                  width: 100.0,
                  child: ElevatedButton(
                    child: Container(
                      child: Text('Salir'),
                    ),
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
