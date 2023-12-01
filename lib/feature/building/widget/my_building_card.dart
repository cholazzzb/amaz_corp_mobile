import 'package:amaz_corp_mobile/shared/component/primary_button.dart';
import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';

class MyBuildingCard extends StatelessWidget {
  const MyBuildingCard({
    super.key,
    required this.locationName,
    required this.onPressDetail,
    required this.onPressLeave,
  });

  final String locationName;
  final void Function() onPressDetail;
  final void Function() onPressLeave;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Row(
          children: [
            Text(locationName),
            PrimaryButton(
              text: "Detail",
              onPressed: onPressDetail,
            ),
            PrimaryButton(
              text: "Leave",
              onPressed: onPressLeave,
            )
          ],
        ),
      ),
    );
  }
}
