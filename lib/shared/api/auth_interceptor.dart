import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.localUserRepo});

  final LocalUserRepo localUserRepo;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await localUserRepo.getToken();
    options.headers['Authorization'] = 'Bearer $token';

    return super.onRequest(options, handler);
  }
}
