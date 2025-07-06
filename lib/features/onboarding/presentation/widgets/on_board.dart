import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/auth/presentation/widgets/title_message.dart';
import 'package:flutter/material.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.desc,
  });
  final String imagePath;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display the actual image
        if (imagePath.isNotEmpty)
          Image.asset(
            imagePath,
            height: 350,
            width: 350,
            fit: BoxFit.contain,
          )
        else
          Container(height: 400, width: 400, color: AppConstants.eslGreenTint),
        const SizedBox(height: 50),
        // Title and description
        TitleMessage(
          title: title,
          message: desc,
          titleTextStyle: boldTextStyle.copyWith(fontSize: 24),
          messageTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
