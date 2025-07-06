import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DirectorCard extends StatelessWidget {
  const DirectorCard({
    super.key,
    required this.name,
    required this.title,
    required this.description,
  });

  final String name;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: currentThemeNotifier.value == lightMode
                  ? AppConstants.eslGreyTint
                  : AppConstants.eslDarkGreyTint,
            ),
            child: Image.asset(AppConstants.engHorizontalGrey$GreyLOGO),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: boldTextStyle.copyWith(
                    color: AppConstants.eslGreen,
                    fontSize: 20,
                  ),
                ),
                Text(title, style: boldTextStyle.copyWith(fontSize: 16)),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
