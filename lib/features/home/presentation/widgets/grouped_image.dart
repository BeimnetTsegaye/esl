import 'package:esl/core/loaders/loading_widget.dart';
import 'package:esl/core/networks/api_endpoints.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/util/url_utils.dart';
import 'package:flutter/material.dart';

class GroupedImage extends StatelessWidget {
  const GroupedImage({
    super.key,
    required this.category,
    this.links = const [],
    this.isExpanded = false,
  });

  final String category;
  final List<String> links;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: isExpanded,
      leading: Container(
        width: 5,
        decoration: const BoxDecoration(color: AppConstants.eslGreen),
      ),
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(top: 20, bottom: 20),
      title: Text(
        category
            .toLowerCase()
            .replaceAll('_', ' ')
            .split(' ')
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(' '),
        style: boldTextStyle,
      ),
      children: [
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          shrinkWrap: true,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          physics: const NeverScrollableScrollPhysics(),
          children: links.map((link) {
            return Container(
              decoration: BoxDecoration(
                color: currentThemeNotifier.value == lightMode
                    ? AppConstants.eslGreyTint
                    : AppConstants.eslDarkGreyTint,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return FadeTransition(
                          opacity: animation,
                          child: Stack(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const BlurryBackgroundWidget(),
                              ),
                              Center(
                                child: Hero(
                                  tag: link,
                                  transitionOnUserGestures: true,
                                  child: Image.network(
                                    buildUrl(link),
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const Center(
                                            child: RotatingImageWidget(),
                                          );
                                        },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Image(
                                        image: AssetImage(
                                          AppConstants
                                              .engHorizontalGrey$GreyLOGO,
                                        ),
                                      );
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Hero(
                  tag: link,
                  transitionOnUserGestures: true,
                  child: Image.network(
                    '${baseUrl.replaceFirst('/api', '')}$link',
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: RotatingImageWidget());
                    },
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) return child;
                          return child;
                        },
                    errorBuilder: (context, error, stackTrace) {
                      return const Image(
                        image: AssetImage(
                          AppConstants.engHorizontalGrey$GreyLOGO,
                        ),
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
