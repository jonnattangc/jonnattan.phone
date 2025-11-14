class DaoNeighbour 
{
  String imei;
  String name;
  String mail;
  String depto;
  String torre;
  bool   hasPet;

  DaoNeighbour( {
    required this.imei, 
    required this.name, 
    required this.mail, 
    required this.depto, 
    required this.torre, 
    required this.hasPet
  } ){
    this.hasPet = hasPet;
  }

  void fromJsonMap( Map<String,dynamic> json )
  {
    this.imei   = json['imei'];
    this.name   = json['name'];
    this.mail   = json['mail'];
    this.depto  = json['depto'];
    this.torre  = json['torre'];
    this.hasPet    = json['pet'];
  }

  Map<String, dynamic> toJsonMap()
  {
    var json = new Map<String, dynamic>();
    json['imei']   = this.imei;
    json['name']   = this.name;
    json['mail']   = this.mail;
    json['depto']  = this.depto;
    json['torre']  = this.torre;
    json['pet']    = this.hasPet;
    return json;
  }

  @override
  String toString() 
  {
    String detail = '${this.name} ${this.depto}${this.torre}';
    return detail;
  }
}