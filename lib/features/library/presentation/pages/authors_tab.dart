// authors_tab.dart
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/widgets/alphabetical_filter.dart';
import 'package:esl/core/widgets/see_all_title.dart';
import 'package:esl/features/library/domain/entities/library.dart';
import 'package:esl/features/library/presentation/blocs/resource_bloc.dart';
import 'package:esl/features/library/presentation/widgets/book_card.dart';
import 'package:esl/features/library/presentation/widgets/name_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AuthorsTab extends StatefulWidget {
  final String? selectedOption;
  final ValueChanged<String> onOptionSelected;
  final List<String> authorNames;
  final List<Library> resources;

  const AuthorsTab({
    super.key,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.authorNames,
    required this.resources,
  });

  @override
  State<AuthorsTab> createState() => _AuthorsTabState();
}

class _AuthorsTabState extends State<AuthorsTab> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ResourceBloc>().state;
    final isLoading = state is AuthorsLoading || 
                     state is ResourceByAuthorsLoading || 
                     state is ResourceLoading;
    
    final authors = isLoading ? List.filled(8, '') : widget.authorNames;
    final resources = isLoading
        ? List.generate(8, (_) => const Library(
            id: '',
            title: '',
            description: '',
            authorId: '',
            departmentId: '',
            documentUrl: '',
            uploaderId: '',
          ))
        : widget.resources;
        
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ResourceBloc>().add(const RefreshLibraryData());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView(
          children: [
            SeeAllTitle(title: 'Authors', onPressed: () {}),
            AlphabeticalFilter(
              selectedOption: widget.selectedOption,
              onOptionSelected: widget.onOptionSelected,
            ),
            const SizedBox(height: 10),
            NameList(authors: authors),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 
                    MediaQuery.orientationOf(context) == Orientation.portrait
                        ? 0.8
                        : 1.8,
              ),
              itemCount: resources.length,
              itemBuilder: (context, index) {
                return BookCard(
                  title: resources[index].title,
                  child: Image.asset(AppConstants.engAbbrivationFullColor,
                  fit: BoxFit.fill,
                  ),
                  downloadUrl: resources[index].documentUrl,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
