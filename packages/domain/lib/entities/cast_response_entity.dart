class CastResponseEntity {
  final List<Map<String, dynamic>> cast;

  CastResponseEntity(this.cast);

  factory CastResponseEntity.fromJson(Map<String, dynamic> json) {
    final cast = List<Map<String, dynamic>>.from(json['cast']);

    return CastResponseEntity(cast);
  }
}
