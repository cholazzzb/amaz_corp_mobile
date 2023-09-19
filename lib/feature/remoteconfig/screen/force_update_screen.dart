import 'dart:io';

import 'package:amaz_corp_mobile/shared/constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({super.key});

  /// TODO: Add android package id
  Future<void> _onPressed() async {
    if (Platform.isAndroid) {
      final appId =
          Platform.isAndroid ? 'YOUR_ANDROID_PACKAGE_ID' : 'YOUR_IOS_APP_ID';
      final url = Uri.parse(
        Platform.isAndroid
            ? "market://details?id=$appId"
            : "https://apps.apple.com/app/id$appId",
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: ColoredBox(
                  color: colorScheme.surfaceVariant,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(Sizes.p16),
                        child: Row(
                          children: [
                            const Text("Your App Need Update!"),
                            ElevatedButton(
                                onPressed: _onPressed,
                                child: const Text("Update"))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
