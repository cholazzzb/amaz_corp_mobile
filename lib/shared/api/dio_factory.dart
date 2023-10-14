import 'package:amaz_corp_mobile/core/user/domain/repository/fss_local_user_repo.dart';
import 'package:amaz_corp_mobile/shared/api/auth_interceptor.dart';
import 'package:dio/dio.dart';

enum InterceptorType { auth }

class DioFactory {
  DioFactory({required this.baseUrl, this.interceptor});

  final String baseUrl;
  final InterceptorType? interceptor;

  Dio create() {
    final dio = Dio(_createBaseOptions());
    switch (interceptor) {
      case InterceptorType.auth:
        dio.interceptors.add(
          AuthInterceptor(
            localUserRepo: FssLocalUserRepo(),
          ),
        );
        break;
      case null:
        break;
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
