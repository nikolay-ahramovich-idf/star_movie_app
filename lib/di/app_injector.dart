import 'package:data/di/data_injector.dart';
import 'package:domain/di/domain_injector.dart';
import 'package:presentation/di/presentation_injector.dart';
import 'package:star_movie_app/flavor_config.dart';

Future<void> initAppInjector(FlavorConfig flavorConfig) async {
  await initDataInjector(
    flavorConfig.apiBaseUrl,
    flavorConfig.apiKeyConfigKey,
  );
  await initDomainInjector();
  initPresentationInjector();
}
