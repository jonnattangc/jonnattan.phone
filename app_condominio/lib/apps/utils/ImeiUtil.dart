import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ImeiUtil {
  String? _imei;
  DateTime? _date = DateTime.now();
  final BuildContext _context;

  ImeiUtil({required BuildContext context}) : this._context = context;

   Future<String> getImei() async {
    final diff = _date!.difference(DateTime.now());
    if (diff.inMinutes > 15 || _imei == null) {
      _imei = await _getDeviceId();
      print('Rescato IMEI: $_imei');
      _date = DateTime.now();
    }
    return _imei ?? '';
  }

  Future<String?> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(_context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // o androidInfo.androidId
    } else if (Theme.of(_context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'Unknown';
    }
    return 'Unsupported Platform';
  }
}
