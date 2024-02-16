import 'package:flutter/material.dart';

void showAmzBottomSheet<T>(
  BuildContext context,
  Widget Function(BuildContext) builder,
) {
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
    builder: builder,
  );
}
