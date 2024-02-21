import 'package:amaz_corp_mobile/shared/component/button.dart';
import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';

class JoinedBuildingCard extends StatelessWidget {
  final bool selected;
  final String locationName;
  final void Function() onPressDetail;
  final void Function() onPressLeave;
  final void Function() onSelectBuilding;

  const JoinedBuildingCard({
    super.key,
    required this.selected,
    required this.locationName,
    required this.onPressDetail,
    required this.onPressLeave,
    required this.onSelectBuilding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(locationName),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!selected)
                  Button(
                    text: "Select",
                    onPressed: onSelectBuilding,
                  ),
                PrimaryButton(
                  text: "Detail",
                  onPressed: onPressDetail,
                ),
                PrimaryButton(
                  text: "Leave",
                  onPressed: onPressLeave,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
