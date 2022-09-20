import 'package:data/const.dart';
import 'package:data/services/api_base_service.dart';
import 'package:domain/repositories/images_repository.dart';

class TMDBImagesRepository implements ImagesRepository {
  final ApiBaseService _tmdbApiService;

  TMDBImagesRepository(
    this._tmdbApiService,
  );

  @override
  Future<String?> getActorPictureById(int id) async {
    final actorImagesResponse = await _tmdbApiService
        .get<Map<String, dynamic>>(_getActorProfilesUri(id));

    if (actorImagesResponse.data == null) {
      return null;
    }

    final actorProfiles = List<Map<String, dynamic>>.from(
      actorImagesResponse.data?['profiles'],
    );

    actorProfiles.sort(
      ((a, b) => a['height'].compareTo(b['height'])),
    );

    return _getActorProfileUrl(actorProfiles.first['file_path']);
  }

  String _getActorProfilesUri(int id) {
    return '/person/$id/images';
  }

  String _getActorProfileUrl(String filePath) {
    return '${TMDBConfig.actorPictureApiPath}$filePath';
  }
}
