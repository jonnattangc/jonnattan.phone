import 'DaoQuestion.dart';

class DataUser {
  final String version = '1.0';
  String? _imei;
  bool? _valid = false;
  DaoQuestion? _info;
  
  static final DataUser _instance = DataUser._internal();

  DataUser._internal();

  factory DataUser() => _instance;  

  void setImei( String imei )
  {
    this._imei = imei;
  }

  void validOk()
  {
    this._valid = true;
  }

 void validNOk()
  {
    this._valid = false;
  }

  void setDao( DaoQuestion info )
  {
    this._info = info;
  }

  @override
  String toString() 
  {
    String detail = 'IMEI: ${this._imei}';
    return detail;
   }
  
  bool isValid()
  {
    bool ret = this._valid ?? false;
    return ret;
  }

  String getImei()
  {
    String imei = this._imei ?? '';
    return imei;
  }

  DaoQuestion? getDao()
  {
    return this._info;
  }

}