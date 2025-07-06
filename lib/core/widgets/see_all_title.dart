import 'package:esl/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SeeAllTitle extends StatelessWidget {
  const SeeAllTitle({super.key, required this.title, required this.onPressed});
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: boldTextStyle),
        TextButton(onPressed: onPressed, child: const Text('See all')),
      ],
    );
  }
}
