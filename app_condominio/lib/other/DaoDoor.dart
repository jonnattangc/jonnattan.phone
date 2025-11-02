
class DaoDoor 
{
  String imei;
  String iddoor;

  DaoDoor({ required this.imei, required this.iddoor});

  DaoDoor.fromJsonMap( Map<String,dynamic> json )
  {
    this.imei   = json['imei'];
    this.iddoor = json['iddoor'];
  }

  toJsonMap()
  {
    var json = new Map<String, dynamic>();
    json['imei']   = this.imei;
    json['iddoor']   = this.iddoor;
    return json;
  }

  @override
  String toString() 
  {
    String detail = '${this.imei} ${this.iddoor}';
    return detail;
  }
}