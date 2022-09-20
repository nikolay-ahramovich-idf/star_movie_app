import 'package:dio/dio.dart';

abstract class ApiBaseService {
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  });

  void updateHeaders(Map<String, dynamic> newHeaders);
}

class ApiServiceImpl implements ApiBaseService {
  final Dio _dio;

  ApiServiceImpl(this._dio);

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get<T>(path, queryParameters: queryParameters);

    return response;
  }

  @override
  void updateHeaders(Map<String, dynamic> newHeaders) {
    _dio.options.headers = newHeaders;
  }
}
