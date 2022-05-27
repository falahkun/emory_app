import 'log_interceptors.dart';
import 'package:dio/dio.dart';

class DioClient {
  final String apiBaseUrl;

  DioClient({
    required this.apiBaseUrl,
  });

  Dio get dio => _getDio();

  Dio _getDio() {
    var options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: 50000,
      receiveTimeout: 50000,
      sendTimeout: 50000,
    );
    var dio = Dio(options);
    dio.interceptors.add(LoggingInterceptors());
    return dio;
  }
}
