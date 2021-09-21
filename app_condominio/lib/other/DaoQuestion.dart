
class DaoQuestion 
{
  String nombre;
  String depto;
  String torre;

  DaoQuestion({ this.nombre, this.depto, this.torre,});

  @override
  String toString() 
  {
    String detail = '${this.nombre} ${this.depto}${this.torre}';
    return detail;
  }

  DaoQuestion.fromJsonMap(Map<String,dynamic> json)
  {
    nombre = json['nombre'];
    depto = json['depto'];
    torre = json['torre'];
  }
}
