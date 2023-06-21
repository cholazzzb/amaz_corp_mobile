import 'dart:convert';

import 'package:amaz_corp_mobile/core/user/data/dto/auth_dto.dart';
import 'package:amaz_corp_mobile/core/user/data/dto/user_dto.dart';
import 'package:amaz_corp_mobile/core/user/data/repository/remote_user_repo.dart';
import 'package:amaz_corp_mobile/core/user/domain/entity/credential_entity.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class HttpRemoteUserRepo implements RemoteUserRepo {
  const HttpRemoteUserRepo(this._dio);

  final Dio _dio;

  @override
  Future<Either<Exception, UserDTO>> postRegister(
    String userName,
    String password,
  ) async {
    const uri = 'api/v1/register';

    final Map<String, dynamic> rawBody = {
      "username": userName,
      "password": password
    };
    String body = json.encode(rawBody);

    try {
      await _dio.post(
        uri,
        data: body,
      );
      return Right(UserDTO());
    } on Exception catch (err) {
      return Left(Exception(err));
    }
  }

  @override
  Future<Either<Exception, Token>> postLogin(
    String userName,
    String password,
  ) async {
    const uri = 'api/v1/login';

    final Map<String, dynamic> rawBody = {
      "username": userName,
      "password": password
    };
    String body = json.encode(rawBody);

    try {
      final res = await _dio.post(
        uri,
        data: body,
      );
      final auth = AuthDTO.fromJSON(res.data);
      return Right(auth.token ?? '');
    } on Exception catch (err) {
      return Left(Exception(err));
    }
  }
}
