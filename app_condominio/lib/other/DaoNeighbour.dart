
class DaoNeighbour 
{
  String imei;
  String name;
  String mail;
  String depto;
  String torre;
  bool   pet;

  DaoNeighbour({ this.imei, this.name, this.mail, this.depto, this.torre, this.pet});

  DaoNeighbour.fromJsonMap( Map<String,dynamic> json )
  {
    this.imei   = json['imei'];
    this.name   = json['name'];
    this.mail   = json['mail'];
    this.depto  = json['depto'];
    this.torre  = json['torre'];
    this.pet    = json['pet'];
  }

  toJsonMap()
  {
    var json = new Map<String, dynamic>();
    json['imei']   = this.imei;
    json['name']   = this.name;
    json['mail']   = this.mail;
    json['depto']  = this.depto;
    json['torre']  = this.torre;
    json['pet']    = this.pet;
    return json;
  }

  @override
  String toString() 
  {
    String detail = '${this.name} ${this.depto}${this.torre}';
    return detail;
  }
}