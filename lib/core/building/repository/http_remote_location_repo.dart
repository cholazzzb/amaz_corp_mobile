import 'dart:convert';

import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/entity/member_entity.dart';
import 'package:amaz_corp_mobile/core/building/entity/room_entity.dart';
import 'package:amaz_corp_mobile/core/building/repository/remote_location_repo.dart';
import 'package:dio/dio.dart';

class HttpRemoteLocationRepo implements RemoteBuildingRepo {
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
  Future<List<BuildingMember>> getMyLocations(String memberId) async {
    const uri = 'api/v1/buildings';

    // final Map<String, dynamic> qp = Map.from({"memberId": memberId});

    final response = await _dio.get(
      uri,
      // queryParameters: qp,
    );

    final List<BuildingMember> buildings = response.data['buildings']!
        .map((b) => BuildingMember.fromJSON(b))
        .toList()
        .cast<BuildingMember>();
    return buildings;
  }

  @override
  Future<List<Building>> getListMyOwnedBuilding() async {
    const uri = 'api/v1/buildings/owned';

    final response = await _dio.get(uri);

    final List<Building> buildings = response.data["data"]!
        .map((blndg) => Building.fromJSON(blndg))
        .toList()
        .cast<Building>();

    return buildings;
  }

  @override
  Future<void> postAddBuilding(
    AddBuildingReq req,
  ) async {
    const uri = 'api/v1/buildings';

    String body = json.encode(req.toJson());

    await _dio.post(uri, data: body);

    return;
  }

  @override
  Future<void> inviteMemberToBuilding(
    InviteMemberToBuildingReq req,
  ) async {
    const uri = 'api/v1/buildings/invite';

    String body = json.encode(req.toJson());

    await _dio.post(uri, data: body);

    return;
  }

  @override
  Future<void> joinBuilding(
    JoinBuildingReq req,
  ) async {
    const uri = 'api/v1/buildings/join';

    String body = json.encode(req.toJson());

    await _dio.post(uri, data: body);
    return;
  }

  @override
  Future<void> leaveBuilding(
    String buildingID,
    String memberID,
  ) async {
    const uri = 'api/v1/buildings/leave';
    final Map<String, dynamic> rawbody = {
      "buildingID": buildingID,
      "memberID": memberID
    };
    String body = json.encode(rawbody);

    await _dio.delete(uri, data: body);
    return;
  }

  @override
  Future<void> editMemberName(RenameMemberNameReq req) async {
    String uri = 'api/v1/members/';

    String body = json.encode(req.toJson());

    await _dio.put(uri, data: body);
    return;
  }

  @override
  Future<List<Room>> getListRoomsByBuildingID(String buildingID) async {
    String uri = "api/v1/buildings/$buildingID/rooms";

    final response = await _dio.get(uri);

    final List<Room> rooms = response.data["rooms"]!
        .map((b) => Room.fromJSON(b))
        .toList()
        .cast<Room>();
    return rooms;
  }

  @override
  Future<List<Member>> getListMemberByBuildingID(String buildingID) async {
    final String uri = 'api/v1/buildings/$buildingID/members';

    final response = await _dio.get(uri);
    final List<Member> members = response.data["members"]!
        .map((m) => Member.fromJSON(m))
        .toList()
        .cast<Member>();
    return members;
  }
}
