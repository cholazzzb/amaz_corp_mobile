import 'package:amaz_corp_mobile/app_dependencies.dart';
import 'package:amaz_corp_mobile/core/user/domain/service/user_service.dart';
import 'package:amaz_corp_mobile/feature/drawer/widget/building_drawer_header.dart';
import 'package:amaz_corp_mobile/feature/drawer/widget/list_my_building.dart';
import 'package:amaz_corp_mobile/feature/drawer/widget/list_my_room.dart';
import 'package:amaz_corp_mobile/routing/user_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LeftDrawer extends ConsumerStatefulWidget {
  const LeftDrawer({super.key});

  @override
  ConsumerState<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends ConsumerState<LeftDrawer> {
  String selectedBuildingID = "";

  @override
  Widget build(BuildContext context) {
    final locationRepo =
        ref.watch(appDependenciesProvider).requireValue.database.locationRepo;

    void onSelectBuilding(buildingID) {
      setState(() {
        selectedBuildingID = buildingID;
      });
      locationRepo.setSelectedBuildingID(buildingID);
    }

    final userSvc = ref.watch(userServiceProvider);
    void logout() {
      userSvc.logout(() {
        context.goNamed(UserRouteName.login.name);
      });
    }

    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: SafeArea(
          child: Column(
            children: [
              BuildingDrawerHeader(logout: logout),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        border: const Border(
                          right: BorderSide(color: Colors.black, width: 1),
                        ),
                      ),
                      child: ListMyBuilding(
                        onSelectBuilding: onSelectBuilding,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Theme.of(context).colorScheme.background,
                        child: ListMyRoom(buildingID: selectedBuildingID),
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
