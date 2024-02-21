import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:amaz_corp_mobile/shared/api/auth_interceptor.dart';
import 'package:dio/dio.dart';

class DioFactory {
  final String baseUrl;

  DioFactory({
    required this.baseUrl,
  });

  Dio create({LocalUserRepo? localUserRepo}) {
    final dio = Dio(_createBaseOptions());

    if (localUserRepo != null) {
      dio.interceptors.add(
        AuthInterceptor(
          localUserRepo: localUserRepo,
        ),
      );
    }
    return dio;
  }

  BaseOptions _createBaseOptions() => BaseOptions(
        // Request base url
        baseUrl: baseUrl,

        receiveTimeout: const Duration(minutes: 15),
        sendTimeout: const Duration(minutes: 15),
        connectTimeout: const Duration(minutes: 15),

        // queryParameters: <String, dynamic>{'parameter1': 'value1'},
        // headers: <String, dynamic>{'header1': 'value1'},
      );
}
