class CastCrewResponseEntity {
  final List<Map<String, dynamic>> cast;
  final List<Map<String, dynamic>> crew;

  CastCrewResponseEntity(
    this.cast,
    this.crew,
  );

  factory CastCrewResponseEntity.fromJson(Map<String, dynamic> json) {
    final cast = List<Map<String, dynamic>>.from(json['cast']);

    final crew = List<Map<String, dynamic>>.from(
      Map<String, List<dynamic>>.from(json['crew'])
          .values
          .expand((crewItem) => crewItem),
    );

    return CastCrewResponseEntity(
      cast,
      crew,
    );
  }
}
