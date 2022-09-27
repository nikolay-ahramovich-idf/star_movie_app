import 'dart:convert';

import 'package:data/const.dart';
import 'package:domain/services/app_config_service.dart';
import 'package:flutter/services.dart';

class AppConfigServiceImpl implements AppConfigService {
  @override
  Future<Map<String, dynamic>> getConfig() async {
    final config = await rootBundle.loadString(DataConfig.configPath);
    return Map.from(jsonDecode(config));
  }

  @override
  Future<S> getConfigValue<S>(String key) async {
    final value = (await getConfig())[key];
    return value as S;
  }
}
