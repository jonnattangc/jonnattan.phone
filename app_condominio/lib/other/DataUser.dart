

import 'DaoQuestion.dart';

class DataUser 
{
  static DataUser _instance;
  String _imei ="123456789";
  bool _valid  = false;
  DaoQuestion _info;
  
  DataUser();

  static DataUser getInstance() 
  {
    if(DataUser._instance == null) 
      DataUser._instance = new DataUser();
    return DataUser._instance;
  }

  void setDao( DaoQuestion aDao )
  {
    this._info = aDao;
  }

  @override
  String toString() 
  {
    if( _info != null )
      return _info.toString();
    else
      return 'sin nombre';
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