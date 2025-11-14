import 'dart:ffi';

class DaoDoor 
{
  final String imei;
  final int doorId;
  final String doorName;
  final bool curretState;

  DaoDoor({ required this.imei, required this.doorId, required this.doorName, required this.curretState});

  Map<String, dynamic> toJsonMap()
  {
    var json = new Map<String, dynamic>();
    json['imei']   = this.imei;
    json['iddoor']   = this.doorId;
    json['name']   = this.doorName;
    json['state']   = this.curretState;
    return json;
  }

  @override
  String toString() 
  {
    String detail = '${this.imei} ${this.doorId}';
    return detail;
  }
}