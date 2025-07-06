import 'package:esl/core/shared/constants.dart';
import 'package:flutter/material.dart';

class TopLogo extends StatelessWidget {
  const TopLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppConstants.eslWhite),
      padding: const EdgeInsets.all(50.0),
      child: Image.asset(AppConstants.engHorizontalFullColor),
    );
  }
}
