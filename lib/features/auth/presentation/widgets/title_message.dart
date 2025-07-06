import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class TitleMessage extends StatelessWidget {
  const TitleMessage({
    super.key,
    required this.title,
    required this.message,
    this.titleTextStyle,
    this.messageTextStyle,
  });

  final String title;
  final String message;
  final TextStyle? titleTextStyle;
  final TextStyle? messageTextStyle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style:
                titleTextStyle ??
                const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            message,
            style:
                messageTextStyle ??
                const TextStyle(fontSize: 20, color: AppConstants.eslGrey),
          ),
        ],
      ),
    );
  }
}

TitleMessage authTitleMessage({required String title, required String message}) {
  return TitleMessage(
    title: title,
    message: message,
    titleTextStyle: authWelcome34TextStyle,
    messageTextStyle: authGreyTextStyle,
  );
}
