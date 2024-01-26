import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuildingCard extends ConsumerWidget {
  const BuildingCard({
    super.key,
    required this.name,
    required this.buildingId,
    required this.isSelected,
    required this.buttonText,
    required this.onPressed,
  });

  final String name;
  final String buildingId;
  final bool isSelected;
  final String buttonText;
  final void Function(String buildingId) onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name),
            PrimaryButton(
              text: buttonText,
              onPressed: isSelected ? null : () => onPressed(buildingId),
            )
          ],
        ),
      ),
    );
  }
}
