import 'package:esl/core/shared/constants.dart';
import 'package:flutter/material.dart';

class LineStepper extends StatelessWidget {
  const LineStepper({super.key, required int currentStep})
    : _currentStep = currentStep;

  final int _currentStep;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Stack(
        children: [
          Container(
            height: 6,
            decoration: BoxDecoration(color: Colors.grey[300]),
          ),
          FractionallySizedBox(
            widthFactor: (_currentStep + 1) / 9,
            child: Container(
              height: 6,
              decoration: const BoxDecoration(color: AppConstants.eslGreen),
            ),
          ),
        ],
      ),
    );
  }
}
