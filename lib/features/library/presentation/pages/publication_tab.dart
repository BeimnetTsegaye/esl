import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/widgets/custom_tab_bar.dart';
import 'package:esl/features/library/domain/entities/library.dart';
import 'package:esl/features/library/presentation/blocs/resource_bloc.dart';
import 'package:esl/features/library/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PublicationTab extends StatefulWidget {
  final List<Library> journalLibrary;
  final List<Library> bookLibrary;

  const PublicationTab({
    super.key,
    required this.journalLibrary,
    required this.bookLibrary,
  });

  @override
  State<PublicationTab> createState() => _PublicationTabState();
}

class _PublicationTabState extends State<PublicationTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> tabs = ['Books', 'Journals'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ResourceBloc>().state;
    final isLoading = state is AuthorsLoading || 
                     state is ResourceByCategoryLoading || 
                     state is ResourceLoading;
    final books = isLoading
        ? List.generate(8, (_) => const Library(
            id: '',
            title: '',
            description: '',
            authorId: '',
            departmentId: '',
            documentUrl: '',
            uploaderId: '',
          ))
        : widget.bookLibrary;
    final journals = isLoading
        ? List.generate(8, (_) => const Library(
            id: '',
            title: '',
            description: '',
            authorId: '',
            departmentId: '',
            documentUrl: '',
            uploaderId: '',
          ))
        : widget.journalLibrary;
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ResourceBloc>().add(const RefreshLibraryData());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: Skeletonizer(
        enabled: isLoading,
        child: Column(
          children: [
            CustomTabBar(tabController: _tabController, tabs: tabs),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio:
                          MediaQuery.orientationOf(context) == Orientation.portrait
                              ? 0.8
                              : 1.8,
                    ),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return BookCard(
                        title: books[index].title,
                        downloadUrl: books[index].documentUrl,
                        child: Image.asset(AppConstants.engHorizontalFullColor),
                      );
                    },
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio:
                          MediaQuery.orientationOf(context) == Orientation.portrait
                              ? 0.8
                              : 1.8,
                    ),
                    itemCount: journals.length,
                    itemBuilder: (context, index) {
                      return BookCard(
                        title: journals[index].title,
                        downloadUrl: journals[index].documentUrl,
                        child: Image.asset(AppConstants.engHorizontalFullColor),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
