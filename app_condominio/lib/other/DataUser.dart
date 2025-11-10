import 'DaoQuestion.dart';

class DataUser {
  String? _imei;
  bool? _valid;
  DaoQuestion? _info;
  
  DataUser({ required String imei, required bool valid,}) : _imei = imei, _valid = valid;


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