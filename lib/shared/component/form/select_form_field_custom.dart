import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';

class SelectFormFieldCustom extends StatelessWidget {
  final bool loading;
  final String errorMessage;
  final String title;
  final String selectedValue;
  final void Function() onPressOpen;
  final void Function(String value)? onSearch;

  const SelectFormFieldCustom({
    super.key,
    this.loading = false,
    this.errorMessage = "",
    required this.title,
    required this.selectedValue,
    required this.onPressOpen,
    this.onSearch,
  });

  @override
  Widget build(context) {
    return FormField(
      builder: (FormFieldState formmState) {
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
                    Text(selectedValue),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        onPressOpen();
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
