import 'package:flutter/material.dart';

class PageLoading extends StatelessWidget 
{
  @override
  Widget build(BuildContext aContext) 
  { 
    return Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('assets/Logo_Fondo_Transparente.png'), height: 150.0,),
              Image.asset( 'assets/load.gif', color: Colors.blue, colorBlendMode: BlendMode.srcATop, width: 100.0,),
              Text( 'Cargando...', style: TextStyle(fontSize: 14,  color: Colors.blue,) ),
            ], ),
        );
  }
    
}
  
class PageError extends StatelessWidget 
{
  final String errorText;

  PageError({required this.errorText});

  @override
  Widget build(BuildContext aContext) 
  { 
    return Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text( "Error de conexión", style: TextStyle(fontSize: 14,  color: Colors.red,) ),
            ], ),
        );
  }
    
}
