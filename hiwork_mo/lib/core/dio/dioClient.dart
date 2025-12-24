import 'package:dio/dio.dart';
import 'package:hiwork_mo/data/local/token_storage.dart';

class DioClient {
  final Dio dio;
  final TokenStorage storage;

  DioClient(this.dio, {TokenStorage? storage})
    : storage = storage ?? TokenStorage() {
    dio.options.headers['Content-Type'] = 'application/json';
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await this.storage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (e, handler) => handler.next(e),
      ),
    );
  }
}
