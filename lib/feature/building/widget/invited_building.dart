import 'package:amaz_corp_mobile/core/building/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/feature/building/controller/building_controller.dart';
import 'package:amaz_corp_mobile/feature/building/controller/member_controller.dart';
import 'package:amaz_corp_mobile/feature/building/widget/building_card.dart';
import 'package:amaz_corp_mobile/feature/building/widget/join_building_bottom_sheet.dart';
import 'package:amaz_corp_mobile/shared/component/skeleton.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvitedBuilding extends ConsumerStatefulWidget {
  const InvitedBuilding({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InvitedBuildingState();
}

enum AsyncState {
  idle,
  loading,
  success,
  error,
}

class _InvitedBuildingState extends ConsumerState<InvitedBuilding> {
  Widget errorWidget(Object err, StackTrace st) {
    return const Center(
      child: Center(
        child: SizedBox(
          width: 200.0,
          height: 100.0,
        ),
      ),
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(Sizes.p8),
        child: Skeleton(
          width: 1000,
        ),
      ),
    );
  }

  Future<void> _onEditMemberName(String name, String memberID) async {
    print("PIKA");
    final controller = ref.read(renameMemberControllerProvider.notifier);
    await controller.renameMember(name: name, memberID: memberID);
  }

  @override
  Widget build(BuildContext context) {
    void onPressClose() {
      Navigator.pop(context);
    }

    Future<void> onJoinSuccess(String memberID) {
      return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return JoinBuildingBottomSheet(
            onPressJoin: (name) => _onEditMemberName(name, memberID),
            onPressClose: onPressClose,
          );
        },
      );
    }

    Widget successWidget(List<BuildingMember> data) {
      return Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final building = data[index];

            Future<void> onPressed(String buildingID) async {
              final joinController =
                  ref.read(joinBuildingControllerProvider.notifier);
              await joinController.joinBuilding(
                  memberID: building.memberID, buildingID: buildingID);
              await onJoinSuccess(building.memberID);
            }

            return BuildingCard(
              name: building.name,
              buildingId: building.id,
              isSelected: false,
              buttonText: "Join",
              onPressed: onPressed,
            );
          },
        ),
      );
    }

    final locationAsync = ref.watch(getListInvitedBuildingsProvider);
    Widget res = locationAsync.when(
      data: successWidget,
      error: errorWidget,
      loading: loadingWidget,
    );
    return res;
  }
}
