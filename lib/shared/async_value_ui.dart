import 'package:amaz_corp_mobile/shared/component/error_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      showErrorAlertDialog(
        context: context,
        title: 'Error',
        exception: error,
      );
    }
  }
}
