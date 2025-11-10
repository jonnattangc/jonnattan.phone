
class DaoDoor 
{
  final String imei;
  final String doorId;

  DaoDoor({ required this.imei, required this.doorId });

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