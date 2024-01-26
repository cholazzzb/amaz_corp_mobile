import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/entity/member_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_controller.g.dart';

@riverpod
class InviteMemberController extends _$InviteMemberController {
  @override
  FutureOr<void> build() => Future.value();

  Future<void> inviteMember({
    required String name,
    required String buildingID,
    void Function()? onSuccess,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _inviteMember(name, buildingID);
      onSuccess?.call();
    });
  }

  Future<void> _inviteMember(String userID, String buildingID) async {
    final svc = ref.read(locationServiceProvider);
    final req =
        InviteMemberToBuildingReq(userID: userID, buildingID: buildingID);
    await svc.inviteMemberToBuilding(req);
  }
}

@riverpod
class RenameMemberController extends _$RenameMemberController {
  @override
  FutureOr<void> build() => Future.value();

  Future<void> renameMember({
    required String memberID,
    required String name,
    void Function()? onSuccess,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _renameMember(memberID, name);
      onSuccess?.call();
    });
  }

  Future<void> _renameMember(String memberID, String name) async {
    final svc = ref.read(locationServiceProvider);
    final req = RenameMemberNameReq(memberID: memberID, name: name);
    await svc.renameMemberName(req);
  }
}

@riverpod
class GetListMemberByNameController extends _$GetListMemberByNameController {
  @override
  FutureOr<List<Member>> build() => Future.value([]);

  Future<void> getListMember({
    required String name,
    void Function(List<Member> members)? onSuccess,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final members = await _getListMember(name);
      onSuccess?.call(members);
      return members;
    });
  }

  Future<List<Member>> _getListMember(String name) async {
    final svc = ref.read(locationServiceProvider);
    return await svc.getListMemberByName(name);
  }
}
