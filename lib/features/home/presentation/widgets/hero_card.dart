import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/util/url_utils.dart';
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key, this.title, this.excerpt, this.imageUrl});
  final String? title;
  final String? excerpt;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: hasImage
            ? DecorationImage(
                image: NetworkImage(buildUrl(imageUrl)),
                fit: BoxFit.cover,
              )
            : null,
        gradient: !hasImage
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppConstants.eslGreen.withValues(alpha: 0.4),
                  AppConstants.eslGreen,
                ],
              )
            : null,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppConstants.eslGreen.withValues(alpha: 0.8),
              Colors.transparent,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: boldTextStyle.copyWith(color: AppConstants.eslWhite),
            ),
            Text(
              excerpt ?? '',
              style: const TextStyle(color: AppConstants.eslWhite),
            ),
          ],
        ),
      ),
    );
  }
}
