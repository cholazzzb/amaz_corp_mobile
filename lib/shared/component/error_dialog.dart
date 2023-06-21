import "dart:io";

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
              const Text("Error")
            ],
          ),
        )
      ],
    );
  }
}

const kDialogDefaultKey = Key('dialog-default-key');

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  String defaultActionText = "OK",
}) async {
  return switch (Platform.isIOS) {
    true => showCupertinoDialog(
        context: context,
        barrierDismissible: cancelActionText != null,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: content != null ? Text(content) : null,
          actions: <Widget>[
            if (cancelActionText != null)
              CupertinoDialogAction(
                child: Text(cancelActionText),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            CupertinoDialogAction(
              key: kDialogDefaultKey,
              child: Text(defaultActionText),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ),
    false => showDialog(
        context: context,
        barrierDismissible: cancelActionText != null,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: content != null ? Text(content) : null,
          actions: <Widget>[
            if (cancelActionText != null)
              TextButton(
                child: Text(cancelActionText),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            TextButton(
              key: kDialogDefaultKey,
              child: Text(defaultActionText),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ),
  };
}

Future<void> showErrorAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: exception.toString(),
      defaultActionText: 'OK',
    );
