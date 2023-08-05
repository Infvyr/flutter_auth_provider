import 'package:dio/dio.dart';
import 'package:flutter_authentication/src/core/index.dart';

class DioClient {
  final Dio _dio = Dio();

  final _baseUrl = 'https://reqres.in/api';

  DioClient() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(Logging());
  }
}

final dio = DioClient()._dio;
