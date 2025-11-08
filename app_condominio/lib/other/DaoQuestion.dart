
class DaoQuestion 
{
  String nombre;
  String depto;
  String torre;

  DaoQuestion({ 
    required this.nombre, 
    required this.depto, 
    required this.torre,}){}

  @override
  String toString() 
  {
    String detail = '${this.nombre} ${this.depto}${this.torre}';
    return detail;
  }

  void fromJsonMap(Map<String,dynamic> json)
  {
    nombre = json['nombre'];
    depto = json['depto'];
    torre = json['torre'];
  }
}
