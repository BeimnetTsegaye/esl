import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/widgets/scrollable_dots_indicator.dart';
import 'package:esl/features/home/domain/entities/news.dart';
import 'package:esl/features/home/presentation/widgets/news_tile.dart';
import 'package:esl/features/library/presentation/blocs/resource_bloc.dart';
import 'package:esl/features/library/presentation/widgets/hero_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewsTab extends StatefulWidget {
  final List<News> popularNews;
  final List<News> latestNews;
  final double currentPage;
  final ValueChanged<int> onPageChanged;

  const NewsTab({
    super.key,
    required this.popularNews,
    required this.latestNews,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ResourceBloc>().state;
    final isLoading = state is AuthorsLoading || 
                     state is LibraryNewsLoading || 
                     state is ResourceLoading;
    final fakeNews = List.generate(
      8,
      (i) => const News(
        id: '1',
        title: 'Library Renovation Completed',
        content: {'fake':'Fake Hero Content'},
        tags: [],
        viewsCount: 0,
        excerpt: '',
        isPublished: false,
        isPromotedToHero: false,
        newsCategoryId: '',
        authorId: '',
        featuredImage: '',
      ),
    );
    final popular = isLoading ? fakeNews : widget.popularNews;
    final latest = isLoading ? fakeNews : widget.latestNews;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ResourceBloc>().add(const RefreshLibraryData());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView(
          children: [
            // Popular News Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text('Popular News', style: boldTextStyle),
            ),
            SizedBox(
              height: 400,
              child: popular.isEmpty
                  ? const Center(child: Text('No popular news available'))
                  : PageView.builder(
                      itemCount: popular.length,
                      onPageChanged: widget.onPageChanged,
                      itemBuilder: (context, index) =>
                          HeroCard(news: popular[index]),
                    ),
            ),
            if (popular.isNotEmpty)
              const SizedBox(height: 10),
              ScrollableDotsIndicator(
                dotsCount: popular.length,
                position: widget.currentPage,
              ),
            const SizedBox(height: 20),
            // Latest News Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text('Latest News', style: boldTextStyle),
            ),
            if (latest.isEmpty)
              const Center(child: Text('No latest news available'))
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: latest.length,
                  
                  itemBuilder: (context, index) {
                    final news = latest[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: NewsTile(
                        title: news.title ?? '',
                        excerpt: news.excerpt ?? '',
                        imageUrl: news.featuredImage,
                        onPressed: () => context.push(AppConstants.newsDetailsRoute, extra: news),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
