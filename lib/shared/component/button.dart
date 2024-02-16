import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary }

class Button extends StatelessWidget {
  final String text;
  final ButtonVariant variant;
  final bool isLoading;
  final VoidCallback? onPressed;
  final bool disabled;

  const Button({
    super.key,
    required this.text,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = getBgColor(context, variant);

    Widget child = switch (isLoading) {
      true => const CircularProgressIndicator(),
      false => Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        )
    };

    return SizedBox(
      height: Sizes.p44,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: backgroundColor,
        ),
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
    );
  }
}

MaterialStateProperty<Color> getBgColor(
  BuildContext context,
  ButtonVariant variant,
) {
  final bgColorMap = <ButtonVariant, Color>{
    ButtonVariant.primary: Theme.of(context).colorScheme.primary,
    ButtonVariant.secondary: Theme.of(context).colorScheme.secondary,
  };

  return MaterialStatePropertyAll(bgColorMap[variant]!);
}
