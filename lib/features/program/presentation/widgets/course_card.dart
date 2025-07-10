import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/program/presentation/widgets/lexical_description_view.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.title,
    required this.duration,
    required this.description,
  });
  final String title;
  final String duration;
  final Map<String, dynamic> description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.maxFinite,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppConstants.eslGreyText),
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            duration,
            style: const TextStyle(
              color: AppConstants.eslGreen,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: AppConstants.eslGrey,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          // SizedBox(
          //   height: 200,
          //   child: LexicalDescriptionView(
          //     description: description,
          //     // useTextOnly: true,
          //   ),
          // ),
        ],
      ),
    );
  }
}
