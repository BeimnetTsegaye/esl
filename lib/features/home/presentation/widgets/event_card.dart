import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
  });
  final String title;
  final String description;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // color: AppConstants.eslWhite,
        border: Border.all(color: AppConstants.eslGreyText),
      ),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: boldTextStyle),
          Text(description),
          Text(
            time,
            style: boldTextStyle.copyWith(
              color: AppConstants.eslGreen,
            ),
          ),
        ],
      ),
    );
  }
}
