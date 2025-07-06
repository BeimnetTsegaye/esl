import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AdBanner extends StatelessWidget {
  const AdBanner({
    super.key,
    required this.adTitle,
    required this.adDescription,
    required this.onPressed,
    required this.onClose,
  });
  final String adTitle;
  final String adDescription;
  final VoidCallback onPressed;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(
            color: AppConstants.eslGreenTint.withValues(alpha: 0.4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        adTitle,
                        style: boldTextStyle,
                        overflow: TextOverflow.ellipsis, // Prevents overflow
                      ),
                    ),
                    IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
                  ],
                ),
                Text(adDescription),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
