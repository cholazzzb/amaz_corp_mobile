import 'package:amaz_corp_mobile/core/location/domain/entity/building_entity.dart';
import 'package:amaz_corp_mobile/core/location/domain/service/building_service.dart';
import 'package:amaz_corp_mobile/core/user/domain/service/user_service.dart';
import 'package:amaz_corp_mobile/routing/app_router.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/component/skeleton.dart';
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
        },
        children: buildings.map<ExpansionPanel>(
          (bm) {
            final selected = bm.id == selectedBuildingID;

            return ExpansionPanel(
              isExpanded: expandedIDs.contains(bm.id),
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Text(bm.name);
              },
              body: ListTile(
                selected: selected,
                selectedColor: Colors.black,
                selectedTileColor: Colors.amber,
                title: Text(bm.name),
                onTap: () {
                  ref
                      .watch(buildingServiceProvider)
                      .updateSelectedBuilding(bm.id);
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        ).toList(),
      );

      return Center(
        child: Column(
          children: [
            BuildingDrawerWidget(
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

class BuildingDrawerWidget extends StatelessWidget {
  const BuildingDrawerWidget({
    super.key,
    required this.logout,
  });

  final VoidCallback logout;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const EndDrawerButton(),
              const Text('My Building'),
              IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
            ],
          ),
        ],
      ),
    );
  }
}
