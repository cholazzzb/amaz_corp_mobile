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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(errorMessage),
                if (child != null) child!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
