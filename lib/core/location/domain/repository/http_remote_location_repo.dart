import 'dart:convert';

import 'package:amaz_corp_mobile/core/location/domain/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/repository/remote_location_repo.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class HttpRemoteLocationRepo implements RemoteLocationRepo {
  const HttpRemoteLocationRepo(this._dio);

  final Dio _dio;

  @override
  Future<List<Building>> getAllLocations() async {
    const uri = 'api/v1/buildings/all';

    final response = await _dio.get(uri);

    final List<Building> buildings = response.data["buildings"]!
        .map((b) => Building.fromJSON(b))
        .toList()
        .cast<Building>();
    return buildings;
  }

  @override
  Future<List<Building>> getMyLocations(String memberId) async {
    const uri = 'api/v1/buildings';

    // final Map<String, dynamic> qp = Map.from({"memberId": memberId});

    final response = await _dio.get(
      uri,
      // queryParameters: qp,
    );

    final List<Building> buildings = response.data['buildings']!
        .map((b) => Building.fromJSON(b))
        .toList()
        .cast<Building>();
    return buildings;
  }

  @override
  Future<Either<Exception, bool>> joinBuilding(
    String memberId,
    String buildingId,
  ) async {
    const uri = 'api/v1/buildings/join';
    final Map<String, dynamic> rawbody = {
      "buildingId": buildingId,
      "memberId": memberId
    };
    String body = json.encode(rawbody);

    try {
      await _dio.post(
        uri,
        data: body,
      );
      return const Right(true);
    } on Exception catch (err) {
      return Left(Exception(err));
    }
  }

  @override
  Future<Either<Exception, bool>> leaveBuilding(
    String memberId,
    String buildingId,
  ) async {
    const uri = 'api/v1/buildings/leave';
    final Map<String, dynamic> rawbody = {
      "buildingId": buildingId,
      "memberId": memberId
    };
    String body = json.encode(rawbody);

    try {
      await _dio.delete(uri, data: body);
      return const Right(true);
    } on Exception catch (err) {
      return Left(Exception(err));
    }
  }
}
