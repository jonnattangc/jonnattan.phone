import 'package:flutter/material.dart';

import 'PageSystem.dart';
import 'RegisterPage.dart';

class PageApp extends StatelessWidget
{
  final String imei;
  final bool validImei;
  PageApp( { required this.imei, required this.validImei} );

  @override
  Widget build(BuildContext context) 
  {
    return validImei ? PageSystem( imei: imei,) : RegisterPage( imei: imei, );
  }
}
  


