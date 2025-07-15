import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/util/url_utils.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    super.key,
    required this.title,
    required this.excerpt,
    required this.imageUrl,
    this.onPressed,
  });
  final String title;
  final String excerpt;
  final String? imageUrl;
  final VoidCallback? onPressed;
 
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      contentPadding: EdgeInsets.zero,
      tileColor: currentThemeNotifier.value == lightMode
          ? AppConstants.eslGreyTint
          : AppConstants.eslDarkGreyTint,
      leading: (imageUrl != null && imageUrl!.isNotEmpty)
          ? Hero(
              tag: imageUrl!,
              child: Image.network(
                buildUrl(imageUrl),
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppConstants.shipImage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  );
                },
              ),
            )
          : Image.asset(AppConstants.shipImage, width: 100, height: 100),
      title: Hero(
        tag: title,
        child: Material(
          type: MaterialType.transparency,
          child: Text(title, overflow: TextOverflow.ellipsis),
        ),
      ),
      subtitle: Hero(
        tag: excerpt,
        child: Material(
          type: MaterialType.transparency,
          child: Text(
            excerpt,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppConstants.eslGreen),
          ),
        ),
      ),
    );
  }
}
