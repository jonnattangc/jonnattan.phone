import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dao/DaoNeighbour.dart';
import 'dao/DaoQuestion.dart';
// import 'DataUser.dart';

class PageRegister extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<PageRegister> {
  String nombre = '';
  String mail = '';
  String depto = '';
  bool mascota = false;
  String torre = 'A';
  bool ingresados = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "Ingrese datos del co-propietario",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          textCapitalization: TextCapitalization.sentences,
          maxLength: 50,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: 'Ingresar Nombre Completo',
              labelText: 'Nombre Copropietario',
              helperText: 'Nombre persona que se registra',
              suffixIcon: Icon(Icons.account_circle)),
          onChanged: _evaluateName,
        ),
        SizedBox(
          height: 10.0,
        ),
        TextField(
          autofocus: false,
          keyboardType: TextInputType.emailAddress,
          maxLength: 50,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: 'Ingresar Email',
              labelText: 'Correo Electronico',
              helperText: 'Mail para comunicación',
              suffixIcon: Icon(Icons.alternate_email)),
          onChanged: _evaluateMail,
          autocorrect: true,
        ),
        SizedBox(
          height: 10.0,
        ),
        TextField(
          autofocus: false,
          keyboardType: TextInputType.number,
          maxLength: 3,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: 'Depto',
              labelText: 'Departamento',
              helperText: 'Número de departamento',
              suffixIcon: Icon(Icons.add_box)),
          onChanged: _evaluateDepto,
          autocorrect: true,
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.transparent,
          ),
          child: Row(
            children: <Widget>[
              // SizedBox(width: 10.0 ,),
              Text(
                "Seleccione: ",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              DropdownButton(
                value: torre,
                items: _getItems(),
                onChanged: _selectTorre,
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(Icons.account_balance),
            ],
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        SwitchListTile(
          activeTrackColor: Colors.blue,
          // isThreeLine: true,
          dense: true, title: Text('Tiene ud. mascota'), value: mascota,
          onChanged: _changedM,
        ),
        SizedBox(
          width: 10.0,
        ),
        _crearBoton(),
        Text(
          ingresados ? "Datos Ingresados correctamente." : "",
          style: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 16, color: Colors.red),
        ),
      ], /*),
      ),*/
    );
  }

  List<DropdownMenuItem<String>> _getItems() {    
    DropdownMenuItem<String> A = DropdownMenuItem(
      child: Text('Torre A'),
      value: 'A',
    );
    DropdownMenuItem<String> B = DropdownMenuItem(
      child: Text('Torre B'),
      value: 'B',
    );
    DropdownMenuItem<String> C = DropdownMenuItem(
      child: Text('Torre C'),
      value: 'C',
    );
    List<DropdownMenuItem<String>> list = [A,B,C];
    return list;
  }

  _changedM(bool newValue) {
    setState(() {
      this.mascota = newValue;
    });
  }

  _selectTorre(String? value) {
    String nameTorre = value ?? 'Desconocido';
    setState(() {
      this.torre = nameTorre;
    });
  }

  _evaluateName(String text) {
    this.nombre = text;
  }

  _evaluateDepto(String text) {
    this.depto = text;
  }

  _evaluateMail(String text) {
    this.mail = text;
  }

  Widget _crearBoton() {
    return ElevatedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: ingresados ? Text('Finalizar') : Text('Registrar'),
      ),
      onPressed: _registrar,
    );
  }

  void _registrar() async {
    
    if (ingresados) {
      Navigator.pushReplacementNamed(context, '/');
      return;
    }

    print("IMEI  ");
    print("Nombre ${this.nombre} ");
    print("Mail ${this.mail} ");
    print("Depto ${this.depto} ");
    print("Torre ${this.torre} ");
    print("Mascota ${this.mascota} ");
    print("Torre ${this.torre} ");

    DaoNeighbour dao = new DaoNeighbour(
        imei: '',
        name: this.nombre,
        mail: this.mail,
        depto: this.depto,
        hasPet: this.mascota,
        torre: this.torre);
    print('##################### Ingreso: ' + dao.toString());
    try {
      final url = Uri.http("190.100.132.139:8080", "save");
      
      final resp = await http.post(url,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: json.encode(dao.toJsonMap()));

      print('##################### Respuesta: ' + resp.statusCode.toString());
      if (resp.statusCode == 201) //201 es CREADO
      {
        final json_data = json.decode(resp.body);
        final dao = new DaoQuestion(nombre: this.nombre, depto: this.depto, torre: this.torre);  
        print('##################### Respuesta: ' + json_data.toString());
        print('##################### Respuesta: ' + dao.toString());
        ingresados = json_data;
      }
    } catch (error) {
      print('##################### Cath');
      ingresados = false;
    }
    setState(() {});
  }
}
