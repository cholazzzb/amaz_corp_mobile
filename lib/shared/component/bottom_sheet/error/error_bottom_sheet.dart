import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';

class ErrorBottomSheet extends StatelessWidget {
  const ErrorBottomSheet({
    super.key,
    required this.errorMessage,
    required this.onPressClose,
    this.child,
  });

  final String errorMessage;
  final void Function() onPressClose;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  highlightColor: Colors.blue,
                  onPressed: onPressClose,
                )
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(Sizes.p32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: Sizes.p64,
                    color: Colors.amber,
                  ),
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                  ),
                  if (child != null) child!,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
