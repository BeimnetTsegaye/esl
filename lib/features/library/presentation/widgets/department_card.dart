import 'package:esl/core/shared/constants.dart';
import 'package:flutter/material.dart';

class DepartmentCard extends StatelessWidget {
  const DepartmentCard({super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset(image, fit: BoxFit.contain)),
          Positioned.fill(
            child: Container(
              color: AppConstants.eslGreen.withValues(alpha: 0.5),
            ),
          ),
          Center(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
