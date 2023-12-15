import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';

class BottomSheetHeader extends StatelessWidget {
  final String title;

  const BottomSheetHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(Sizes.p8),
          child: Text(title),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
