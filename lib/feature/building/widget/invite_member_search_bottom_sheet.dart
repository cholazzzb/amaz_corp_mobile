import 'package:amaz_corp_mobile/core/user/entity/user_entity.dart';
import 'package:amaz_corp_mobile/feature/user/controller/user_controller.dart';
import 'package:amaz_corp_mobile/shared/component/bottom_sheet/bottom_sheet_header.dart';
import 'package:amaz_corp_mobile/shared/component/form/search_input.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InviteMemberSearchBottomSheet extends ConsumerWidget {
  final String title;
  final void Function(UserQuery selected) onSelect;

  const InviteMemberSearchBottomSheet({
    super.key,
    required this.title,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getListUserByUsernameControllerProvider);
    final List<UserQuery> list = state.hasValue ? state.value! : [];

    final controller =
        ref.read(getListUserByUsernameControllerProvider.notifier);

    void onSearch(String text) {
      controller.getListUser(username: text);
    }

    Widget listWidget = state.when(
      loading: () => const Expanded(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (err, st) => const Text("Error"),
      data: (data) {
        if (data.isEmpty) {
          return const Expanded(child: Text("No Member Found"));
        }
        return Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              final item = list[index];
              return InkWell(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.p8),
                    child: Text(item.username),
                  ),
                ),
                onTap: () {
                  onSelect(item);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );

    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.2,
            maxChildSize: 0.75,
            builder: (_, controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Sizes.p24),
                    topRight: Radius.circular(Sizes.p24),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.remove, color: Colors.grey[600]),
                    BottomSheetHeader(
                      title: title,
                    ),
                    SearchInput(
                      onSearch: onSearch,
                    ),
                    listWidget,
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
