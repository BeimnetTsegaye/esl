import 'package:esl/core/shared/constants.dart';
import 'package:esl/features/auth/presentation/widgets/clip_design.dart';
import 'package:flutter/material.dart';

class LogoWithClip extends StatelessWidget {
  const LogoWithClip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Image.asset(
          AppConstants.engHorizontalFullColor,
          height: 60,
          fit: BoxFit.contain,
        ),
        const ClipDesign(),
      ],
    );
  }
}
