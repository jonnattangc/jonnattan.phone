import 'package:flutter/material.dart';

import 'PageSystem.dart';
import 'PageRegister.dart';

class PageApp extends StatelessWidget
{
  final bool vali_Imei;

  PageApp( {required this.vali_Imei} );

  @override
  Widget build(BuildContext context) {
    return vali_Imei ? PageSystem() : RegisterPage( );
  }
}
  


