import 'dart:convert';

import 'package:amaz_corp_mobile/core/user/data/dto/auth_dto.dart';
import 'package:amaz_corp_mobile/core/user/data/repository/remote_user_repo.dart';
import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:amaz_corp_mobile/core/user/entity/user_entity.dart';
import 'package:dio/dio.dart';

class HttpRemoteUserRepo implements RemoteUserRepo {
  const HttpRemoteUserRepo(this._dio);

  final Dio _dio;

  @override
  Future<void> postRegister(
    String userName,
    String password,
  ) async {
    const uri = 'api/v1/register';

    final Map<String, dynamic> rawBody = {
      "username": userName,
      "password": password
    };
    String body = json.encode(rawBody);

    await _dio.post(
      uri,
      data: body,
    );
  }

  @override
  Future<Token> postLogin(
    String userName,
    String password,
  ) async {
    const uri = 'api/v1/login';

    final Map<String, dynamic> rawBody = {
      "username": userName,
      "password": password
    };
    String body = json.encode(rawBody);

    final res = await _dio.post(
      uri,
      data: body,
    );
    final auth = AuthDTO.fromJSON(res.data);
    return auth.token ?? '';
  }

  @override
  Future<List<UserQuery>> getListUserByUsername(String req) async {
    const uri = 'api/v1/users';

    final response = await _dio.get(uri, queryParameters: {
      "username": req,
    });

    final List<UserQuery> members = response.data["data"]!
        .map((m) => UserQuery.fromJSON(m))
        .toList()
        .cast<UserQuery>();
    return members;
  }
}
