import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/util/url_utils.dart';
import 'package:esl/features/home/domain/entities/news.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HeroCard extends StatelessWidget {
  final News? news;
  final double height;
  final double width;

  const HeroCard({
    super.key,
    required this.news,
    this.height = 400,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: news != null
          ? () => context.push(AppConstants.newsDetailsRoute, extra: news)
          : null,
      child: Stack(
        children: [
          if (news?.featuredImage != null)
            Image.network(
              buildUrl(news!.featuredImage),
              fit: BoxFit.cover,
              height: height,
              width: width,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/book0.png',
                fit: BoxFit.cover,
                height: height,
                width: width,
              ),
            )
          else
            Image.asset(
              'assets/book0.png',
              fit: BoxFit.cover,
              height: height,
              width: width,
            ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                   if (Skeletonizer.of(context).enabled) AppConstants.eslGreen.withValues(alpha: 1) else AppConstants.eslGreen.withValues(alpha: 1),
                    if (Skeletonizer.of(context).enabled) AppConstants.eslGreen.withValues(alpha: 0.7) else Colors.grey.withValues(alpha: 0.7),
                    if (Skeletonizer.of(context).enabled) AppConstants.eslGreen.withValues(alpha: 0.3) else Colors.grey.withValues(alpha: 0.3),
                    if (Skeletonizer.of(context).enabled) AppConstants.eslGreen.withValues(alpha: 0) else Colors.grey.withValues(alpha: 0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton.ignore(
                    child: Text(
                      news?.viewsCount != null
                          ? news!.viewsCount.toString()
                          : '0',
                      style: const TextStyle(
                        color: AppConstants.eslYellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    news?.title ?? 'News Title Placeholder',
                    style: boldTextStyle.copyWith(
                      color: AppConstants.eslWhite,
                      fontSize: 20,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    news?.excerpt ?? 'Content placeholder',
                    style: const TextStyle(color: AppConstants.eslGreyText),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
