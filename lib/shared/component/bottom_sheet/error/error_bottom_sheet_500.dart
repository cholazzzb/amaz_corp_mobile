import 'package:flutter/material.dart';

import 'package:amaz_corp_mobile/shared/component/bottom_sheet/error/error_bottom_sheet.dart';

class ErrorBottomSheet500 extends StatelessWidget {
  final void Function() onPressClose;
  final Widget? child;

  const ErrorBottomSheet500({
    super.key,
    required this.onPressClose,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorBottomSheet(
      errorMessage:
          "Opps kami sedang mengalami gangguan, coba beberapa saat lagi!",
      onPressClose: onPressClose,
    );
  }
}
