import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'other/PageHome.dart';

// Ejemplo asumiendo que el script de ejecución define una variable FLUTTER_ENV
const String FLUTTER_ENV = String.fromEnvironment('FLUTTER_ENV', defaultValue: 'development');

Future<void> main() async {
  await dotenv.load(fileName: ".env.$FLUTTER_ENV");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Jonnattan'),
      debugShowCheckedModeBanner: false,
      title: 'Jonnattan App',
      /*supportedLocales: [
            const Locale('en', 'US'),
            const Locale('es', 'ES'),
          ],*/
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0x99, 0x66, 0x11, 1.0), //#996611
        primarySwatch: Colors.grey,
        brightness: Brightness.light,
        textTheme: TextTheme(
          titleSmall: TextStyle(
            fontSize: 27.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0x99, 0x66, 0x11, 1.0),
          ),
        ),
      ),
    );
  }
}
