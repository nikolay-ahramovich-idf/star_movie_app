import 'package:data/services/api_base_service.dart';
import 'package:domain/repositories/images_repository.dart';

class TMDBImagesRepository implements ImagesRepository {
  final ApiBaseService _tmdbApiService;

  TMDBImagesRepository(
    this._tmdbApiService,
  );

  @override
  Future<List<Map<String, dynamic>>?> getActorsProfiles(int id) async {
    try {
      final actorImagesResponse = await _tmdbApiService
          .get<Map<String, dynamic>>(_getActorProfilesUri(id));

      if (actorImagesResponse.data == null) {
        return null;
      }

      final actorProfiles = List<Map<String, dynamic>>.from(
        actorImagesResponse.data?['profiles'],
      );

      return actorProfiles;
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  String _getActorProfilesUri(int id) {
    return '/person/$id/images';
  }
}
