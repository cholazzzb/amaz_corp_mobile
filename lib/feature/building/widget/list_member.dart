import 'package:amaz_corp_mobile/core/building/entity/member_entity.dart';
import 'package:amaz_corp_mobile/core/building/service/location_service.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListMember extends ConsumerWidget {
  const ListMember({super.key, required this.buildingID});

  final String buildingID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("listmember $buildingID");
    final AsyncValue<List<Member>> members =
        ref.watch(getListMemberByBuildingIDProvider(buildingID));

    Future<void> onPressRefetch() async {
      final _ = ref.refresh(getListMemberByBuildingIDProvider(buildingID));
    }

    Widget loadingWidget() {
      return const Center(child: CircularProgressIndicator());
    }

    Widget errorWidget(e, st) {
      return Center(
        child: Column(
          children: [
            const Text("Failed to get list members"),
            ElevatedButton(
              onPressed: onPressRefetch,
              child: const Text("Retry"),
            )
          ],
        ),
      );
    }

    Widget successWidget(List<Member> data) {
      return Expanded(
        flex: 1,
        child: RefreshIndicator(
          onRefresh: onPressRefetch,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final item = data[index];
              return MemberCard(item: item);
            },
          ),
        ),
      );
    }

    return members.when(
      data: successWidget,
      error: errorWidget,
      loading: loadingWidget,
    );
  }
}

class MemberCard extends StatelessWidget {
  const MemberCard({
    super.key,
    required this.item,
  });

  final Member item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(item.name), const PrimaryButton(text: 'Coba')],
        ),
      ),
    );
  }
}
