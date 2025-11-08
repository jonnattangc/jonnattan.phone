// import 'DaoQuestion.dart';

class DataUser {

  static late final DataUser _instance = DataUser._internal();
  String _imei ="123456789";
  bool _valid  = false;
  // DaoQuestion _info = new DaoQuestion({ nombre: 'sin nombre', depto: 'sin departamento' , torre : 'sin torre'});
  
  DataUser(){
    //_info = null;
  }

  DataUser._internal();

  static DataUser getInstance() 
  {
    _instance = _instance ?? new DataUser();
    return _instance;
  }

  //void setDao( DaoQuestion info )
  //{
  //  this._info = info;
  //}

  @override
  String toString() 
  {
    String detail = 'IMEI: ${this._imei}';
    return detail;
    //if( _info != null )
    //  return _info.toString();
    //else
    //  return 'sin nombre';
   }
  
  bool isValid()
  {
    return _valid;
  }

  void imeiValid()
  {
    _valid = true;
  }

  void setIMEI( String aImei )
  {
    this._imei = aImei;
  }

  String getImei()
  {
    return _imei;
  }

}