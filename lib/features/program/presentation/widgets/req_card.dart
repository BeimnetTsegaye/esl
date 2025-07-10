import 'package:esl/core/shared/constants.dart';
import 'package:flutter/material.dart';

class ReqCard extends StatelessWidget {
  final String title;
  final Map<String, dynamic> description;
  final IconData? icon;
  final Color? iconColor;

  const ReqCard({
    super.key,
    required this.title,
    required this.description,
    this.icon = Icons.description,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      elevation: 0.2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 50,
                  color: const Color.fromARGB(255, 193, 193, 193),
                  child: Icon(
                    icon ?? Icons.description,
                    color: AppConstants.eslGrey,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
