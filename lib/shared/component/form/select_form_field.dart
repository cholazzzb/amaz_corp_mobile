import 'package:amaz_corp_mobile/shared/component/bottom_sheet/select_list_bottom_sheet.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';

String defaultSelect(value) => "";

class SelectFormField<T> extends StatelessWidget {
  final bool loading;
  final String errorMessage;
  final String title;
  final T selectedValue;
  final void Function(T selectedValue) onSelect;
  final List<T> list;
  final String Function(T value) selectValue;

  const SelectFormField({
    super.key,
    this.loading = false,
    this.errorMessage = "",
    required this.title,
    required this.selectedValue,
    required this.list,
    this.selectValue = defaultSelect,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState formState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
              child: Row(
                children: [
                  Text(title),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Sizes.p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectValue(selectedValue)),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        const SingleSelectList().showBottomSheet<T>(
                          context,
                          list: list,
                          title: title,
                          onSelect: onSelect,
                          selectValue: selectValue,
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
