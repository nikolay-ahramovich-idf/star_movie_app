import 'dart:convert';

import 'package:data/const.dart';
import 'package:flutter/services.dart';

abstract class AppConfigService {
  Future<Map<String, dynamic>> getConfig();
}

class AppConfigServiceImpl implements AppConfigService {
  @override
  Future<Map<String, dynamic>> getConfig() async {
    final config = await rootBundle.loadString(DataConfig.configPath);
    return Map.from(jsonDecode(config));
  }
}
