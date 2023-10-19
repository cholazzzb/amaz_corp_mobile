import 'package:amaz_corp_mobile/core/location/domain/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/service/building_service.dart';
import 'package:amaz_corp_mobile/core/user/domain/service/user_service.dart';
import 'package:amaz_corp_mobile/feature/drawer/building_drawer_controller.dart';
import 'package:amaz_corp_mobile/feature/drawer/widget/building_drawer_header.dart';
import 'package:amaz_corp_mobile/feature/drawer/widget/building_expansion_panel_body.dart';
import 'package:amaz_corp_mobile/routing/app_router.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/component/skeleton.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BuildingDrawer extends ConsumerStatefulWidget {
  const BuildingDrawer({super.key});

  @override
  ConsumerState<BuildingDrawer> createState() => _BuildingDrawerState();
}

class _BuildingDrawerState extends ConsumerState<BuildingDrawer> {
  Set<String> expandedIDs = <String>{};

  @override
  Widget build(BuildContext context) {
    final myBuildingAsync = ref.watch(getMyBuildingsProvider);
    final userService = ref.watch(userServiceProvider);
    final buildingDrawerController =
        ref.watch(buildingDrawerControllerProvider.notifier);

    void logout() {
      userService.logout(() {
        context.goNamed(AppRoute.login.name);
      });
    }

    Widget loadingWidget() {
      return const Skeleton();
    }

    Widget errorWidget(Object err, StackTrace st) {
      return const Text('Error');
    }

    Widget successWidget((String, List<BuildingMember>) data) {
      final (selectedBuildingID, buildings) = data;

      ExpansionPanelList xList = ExpansionPanelList(
        expansionCallback: (int index, bool isExpaned) {
          final String buildingID = buildings[index].id;
          setState(() {
            if (expandedIDs.contains(buildingID)) {
              expandedIDs.remove(buildingID);
            } else {
              expandedIDs.add(buildingID);
            }
          });
          if (isExpaned) {
            buildingDrawerController.updateListRoomByBuildingID(buildingID);
          }
        },
        children: buildings.map<ExpansionPanel>(
          (bm) {
            final selected = bm.id == selectedBuildingID;

            return ExpansionPanel(
                isExpanded: expandedIDs.contains(bm.id),
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Row(
                    children: [
                      const Padding(padding: EdgeInsets.all(Sizes.p12)),
                      Text(bm.name)
                    ],
                  );
                },
                body: BuildingExpansionPanelBody(buildingID: bm.id));
          },
        ).toList(),
      );

      return Center(
        child: Column(
          children: [
            BuildingDrawerHeader(
              logout: logout,
            ),
            Expanded(
              child: Column(
                children: [xList],
              ),
            ),
            PrimaryButton(
              text: 'Search Building',
              onPressed: () => {context.goNamed(AppRoute.location.name)},
            ),
          ],
        ),
      );
    }

    Widget drawer = myBuildingAsync.when(
      loading: loadingWidget,
      error: errorWidget,
      data: successWidget,
    );

    return Drawer(child: drawer);
  }
}
