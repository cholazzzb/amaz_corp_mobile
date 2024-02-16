import 'package:amaz_corp_mobile/shared/component/bottom_sheet/bottom_sheet_header.dart';
import 'package:amaz_corp_mobile/shared/component/form/search_input.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';

void _defaultOnSelect(value) {}

String _defaultSelectValue(value) => "";

class SingleSelectList {
  SingleSelectList();

  static void showBottomSheet<T>(
    BuildContext context, {
    required List<T> list,
    required String title,
    void Function(T value) onSelect = _defaultOnSelect,
    String Function(T value) selectValue = _defaultSelectValue,
    void Function(String value)? onSearch,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
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
                      if (onSearch != null)
                        SearchInput(
                          onSearch: onSearch,
                        ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (_, index) {
                            final item = list[index];
                            return InkWell(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(Sizes.p8),
                                  child: Text(selectValue(item)),
                                ),
                              ),
                              onTap: () {
                                onSelect(item);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
