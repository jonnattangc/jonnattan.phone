
class DaoQuestion 
{
  final String nombre;
  final String depto;
  final String torre;

  DaoQuestion({ 
    required this.nombre, 
    required this.depto, 
    required this.torre,});

  @override
  String toString() 
  {
    String detail = '${this.nombre} ${this.depto}${this.torre}';
    return detail;
  }
  
}
