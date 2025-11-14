import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app_condominio/apps/DataUser.dart';
import 'package:app_condominio/apps/dao/DaoQuestion.dart';

class Services {

  DateTime? _date = DateTime.now();
  final Map<String, String> _headers;
  final String _url_base = 'api.jonnattan.cl';

  Services() : _headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST',
      'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept'
  };

  Future<DataUser?> validateImei( final String imei ) async {
    DataUser? user;
    final diff = _date!.difference(DateTime.now());
    if (diff.inMinutes > 15) {
      user = await _getUser(imei);
      print('Rescato IMEI: $imei');
      _date = DateTime.now();
    }
    return user;
  }

  _getHeaders() => () {
    String auth_key = dotenv.env['AUTH_KEY'] ?? 'none';
    _headers['Authorization'] = 'Basic ' + auth_key;
    return _headers;
  };

  Future<DataUser?> _getUser( final String imei ) async {
    
    DataUser? user = DataUser();
    String path = '/mobile/validate/' + imei;
    print('Calling to: Get: ' + path);
    final uri = Uri.https(_url_base, path);

    try {
      final http.Response resp = await http.get(uri, headers: _getHeaders());
      print('Respuesta HTTP: ' + resp.statusCode.toString());
      if (resp.statusCode == 200) {
        user.setImei(imei);
        user.validOk();
        final data_json = json.decode(resp.body);
        final dao = DaoQuestion(
          nombre: data_json['nombre'],
          depto: data_json['depto'],
          torre: data_json['torre'],
        );
        print('Objeto recibido: ' + dao.toString());
        user.setDao(dao);
      }
    } catch (error, stackTrace) {
      print('Error: $error Stack $stackTrace');
    }
    return user;
  }

}
