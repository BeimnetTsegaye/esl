// ignore_for_file: avoid_dynamic_calls

import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    super.key,
    required this.entry,
  });
  final MapEntry<String, dynamic> entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: currentThemeNotifier.value == lightMode ? AppConstants.eslGreyTint : AppConstants.eslDarkGreyTint,
        // borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('"${entry.value['story'] as String}"',),
          ListTile(
            leading: CircleAvatar(
              child: Image.asset(
                AppConstants.engAbbrivationWhite$WhiteLOGO,
                // width: 70,
                // height: 70,
              ),
            ),
            title: Text(entry.key,
                style: boldTextStyle),
            subtitle: Text(entry.value['position'] as String),
          ),
        ],
      ),
    );
  }
}
