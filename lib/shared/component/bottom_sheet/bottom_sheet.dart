import 'package:flutter/material.dart';

void showAmzBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
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
    builder: builder,
  );
}
