import 'package:amaz_corp_mobile/core/location/domain/repository/remote_location_repo.dart';
import 'package:amaz_corp_mobile/core/location/domain/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/user/data/repository/local_user_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

class LocationService {
  LocationService(this.ref);
  final Ref ref;

  late String memberId;
  late String buildingId;

  Future<bool> joinBuilding(
    String memberId,
    String buildingId,
  ) async {
    try {
      final res = await ref
          .read(remoteLocationRepoProvider)
          .joinBuilding(memberId, buildingId);
      return res.right;
    } on Exception {
      return false;
    }
  }

  Future<bool> leaveBuilding(
    String memberId,
    String buildingId,
  ) async {
    try {
      final res = await ref
          .read(remoteLocationRepoProvider)
          .leaveBuilding(memberId, buildingId);
      return res.right;
    } on Exception {
      return false;
    }
  }

  Future<List<Building>> getMyLocations() async {
    try {
      final localUserRepo = ref.watch(localUserRepoProvider);
      final memberId = await localUserRepo.getMemberId();
      final res =
          await ref.read(remoteLocationRepoProvider).getMyLocations(memberId);
      return res;
    } on Exception {
      return [];
    }
  }
}

@Riverpod(keepAlive: true)
LocationService locationService(LocationServiceRef ref) {
  return LocationService(ref);
}

@riverpod
Future<List<Building>> getAllLocations(
  GetAllLocationsRef ref,
) async {
  try {
    return await ref.read(remoteLocationRepoProvider).getAllLocations();
  } on Exception {
    return [];
  }
}

@riverpod
Future<List<Building>> getMyLocations(GetMyLocationsRef ref) async {
  try {
    return await ref.read(locationServiceProvider).getMyLocations();
  } on Exception {
    return [];
  }
}
