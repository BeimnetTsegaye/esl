import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/util/url_utils.dart';
import 'package:esl/features/home/domain/entities/news.dart';
import 'package:esl/features/home/presentation/widgets/notification_tile.dart';
import 'package:esl/features/program/presentation/widgets/lexical_description_view.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewsDetail extends StatefulWidget {
  final News? news;

  const NewsDetail({super.key, this.news});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final news = widget.news;

    if (news == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('News Detail'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(child: Text('News not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Featured Image
                  if (news.featuredImage != null &&
                      news.featuredImage!.isNotEmpty)
                    Hero(
                      tag: news.featuredImage!,
                      child: Image.network(
                        buildUrl(news.featuredImage),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/book0.png',
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          );
                        },
                      ),
                    )
                  else
                    Image.asset(
                      'assets/book0.png',
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                  const SizedBox(height: 10),

                  // Views and Likes Row
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          FluentIcons.eye_24_regular,
                          color: currentThemeNotifier.value == lightMode
                              ? AppConstants.eslGrey
                              : AppConstants.eslGreyText,
                        ),
                        onPressed: () => context.pop(),
                      ),
                      Text('${news.viewsCount ?? 0}'),
                      IconButton(
                        icon: Icon(
                          FluentIcons.thumb_like_20_regular,
                          color: currentThemeNotifier.value == lightMode
                              ? AppConstants.eslGrey
                              : AppConstants.eslGreyText,
                        ),
                        onPressed: () {},
                      ),
                      Text('${news.count?.likes ?? 0}'),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Title
                  Hero(
                    tag: news.title ?? 'No Title',
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        news.title ?? 'No Title',
                        style: boldTextStyle.copyWith(
                          color: currentThemeNotifier.value == lightMode
                              ? AppConstants.eslGrey
                              : AppConstants.eslGreyText,
                          fontSize: 20,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Tags
                  if (news.tags != null && news.tags!.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: news.tags!
                            .map(
                              (tag) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(tag),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),

                  // Date
                  Text(
                    news.startDate != null
                        ? _formatDate(news.startDate!)
                        : 'No date available',
                    style: TextStyle(
                      color: currentThemeNotifier.value == lightMode
                          ? AppConstants.eslGrey
                          : AppConstants.eslGreyText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Author info
                  if (news.author != null)
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${news.author!.firstName ?? ''} ${news.author!.lastName ?? ''}'
                              .trim(),
                          style: TextStyle(
                            color: currentThemeNotifier.value == lightMode
                                ? AppConstants.eslGrey
                                : AppConstants.eslGreyText,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),

                  // Category
                  if (news.newsCategory != null)
                    Row(
                      children: [
                        const Icon(Icons.category, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          news.newsCategory!.category ?? '',
                          style: TextStyle(
                            color: currentThemeNotifier.value == lightMode
                                ? AppConstants.eslGrey
                                : AppConstants.eslGreyText,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  // Content
                  Hero(
                    tag: news.excerpt!,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        news.excerpt!,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 600,
                    child: LexicalDescriptionView(description: news.content)),

                  const SizedBox(height: 20),

                  // Comment Section
                  const Text('Leave a Comment', style: boldTextStyle),
                  const SizedBox(height: 10),
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Write your comment here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: AppConstants.eslGrey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.eslGreenTint,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                    ),
                    child: const Text('Post Comment'),
                  ),
                  const SizedBox(height: 20),

                  // Comments List
                  const Text('Comments', style: boldTextStyle),
                  const SizedBox(height: 10),
                  if (news.comments != null && news.comments!.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: news.comments!.length,
                      itemBuilder: (context, index) {
                        final comment = news.comments![index];
                        return NotificationTile(
                          title: 'User',
                          date: comment.createdAt != null
                              ? _formatDate(comment.createdAt!)
                              : 'Unknown date',
                          description: comment.content ?? 'No content',
                        );
                      },
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'No comments yet. Be the first to comment!',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -300,
            child: IgnorePointer(
              child: Image.asset(
                height: MediaQuery.of(context).size.height * 0.5,
                AppConstants.engHorizontalGrey$GreyLOGO,
                fit: BoxFit.cover,
                color: currentThemeNotifier.value == lightMode
                    ? AppConstants.eslGrey.withValues(alpha: 0.1)
                    : AppConstants.eslGreenTint.withValues(alpha: 0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
