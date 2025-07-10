import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DirectorCard extends StatelessWidget {
  const DirectorCard({
    super.key,
    required this.name,
    required this.title,
    required this.description,
  });

  final String name;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppConstants.eslGreyTint),
      // padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90,
            height: 120,
            // padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 205, 201, 201),
            ),
            child: Image.asset(
              AppConstants.engHorizontalGrey$GreyLOGO,
              fit: BoxFit.contain,
              color: AppConstants.eslGrey,
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Capt. $name',
                    style: boldTextStyle.copyWith(
                      fontSize: 20,
                      color: AppConstants.eslGreen,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(description, maxLines: 3, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
