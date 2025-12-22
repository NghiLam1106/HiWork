import 'package:dio/dio.dart';
import 'package:hiwork_mo/data/local/token_storage.dart';

class DioClient {
  final Dio dio;
  final TokenStorage storage;

  DioClient({
    TokenStorage? storage,
    BaseOptions? options,
  })  : storage = storage ?? TokenStorage(),
        dio = Dio(
          options ??
              BaseOptions(
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 20),
                headers: const {'Content-Type': 'application/json'},
              ),
        ) {
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
