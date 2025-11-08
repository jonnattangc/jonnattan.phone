
class DaoDoor 
{
  String imei;
  String doorId;

  DaoDoor({ 
    required this.imei, 
    required this.doorId 
  }){

  }

  void fromJsonMap( Map<String,dynamic> json )
  {
    this.imei   = json['imei'];
    this.doorId = json['iddoor'];
  }

  Map<String, dynamic> toJsonMap()
  {
    var json = new Map<String, dynamic>();
    json['imei']   = this.imei;
    json['iddoor']   = this.doorId;
    return json;
  }

  @override
  String toString() 
  {
    String detail = '${this.imei} ${this.doorId}';
    return detail;
  }
}