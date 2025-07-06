import 'package:esl/core/widgets/alphabetical_filter.dart';
import 'package:esl/core/widgets/see_all_title.dart';
import 'package:esl/features/home/domain/entities/news.dart';
import 'package:esl/features/library/domain/entities/author.dart';
import 'package:esl/features/library/domain/entities/department.dart';
import 'package:esl/features/library/domain/entities/library.dart';
import 'package:esl/features/library/domain/entities/library_news.dart';
import 'package:esl/features/library/domain/entities/research.dart';
import 'package:esl/features/library/domain/entities/resource.dart';
import 'package:esl/features/library/presentation/blocs/resource_bloc.dart';
import 'package:esl/features/library/presentation/pages/authors_tab.dart';
import 'package:esl/features/library/presentation/pages/department_tab.dart';
import 'package:esl/features/library/presentation/pages/news_tab.dart';
import 'package:esl/features/library/presentation/pages/publication_tab.dart';
import 'package:esl/features/library/presentation/widgets/book_card.dart';
import 'package:esl/features/library/presentation/widgets/name_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // State variables for different sections
  List<String> authorNames = [];
  List<Library> departmentsLibrary = [];
  List<Library> authorLibrary = [];
  List<Library> journalLibrary = [];
  List<Library> publicationLibrary = [];
  List<Research> resourcesByCategory = [];
  List<Author> resourcesByAuthors = [];
  List<Department> resourcesByDepartment = [];
  List<String> departments = [];
  List<News> popularNews = [];
  List<News> latestNews = [];
  LibraryNews? libraryNews;
  double _currentPage = 0;

  // Loading states for different sections
  bool _isOverviewLoading = true;
  bool _isAuthorsLoading = true;
  bool _isAuthorsResourcesLoading = true;
  bool _isDepartmentsLoading = true;
  bool _isPublicationsLoading = true;
  bool _isNewsLoading = true;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index.toDouble();
    });
  }

  final List<String> tabs = [
    'All',
    'Authors',
    'Department',
    'Publications and journals',
    'News',
  ];
  String? _selectedOption = 'A';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_handleTabChange);
    _fetchInitialData();
  }

  void _fetchInitialData() {
    final resourceBloc = context.read<ResourceBloc>();

    // Fetch overview data (contains authors, departments, publications, news)
    resourceBloc.add(const GetResources());

    // Fetch individual tab data for better performance
    resourceBloc.add(const GetAuthors());
    resourceBloc.add(const GetResourceByAuthors());
    resourceBloc.add(const GetResourceByDepartment());
    resourceBloc.add(const GetResourceByCategory());
    resourceBloc.add(const GetLibraryNews());
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  void _onOptionSelected(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  void _updateLoadingStates(ResourceState state) {
    setState(() {
      if (state is ResourceLoading) {
        _isOverviewLoading = true;
      } else if (state is ResourceLoaded) {
        _isOverviewLoading = false;
        _processOverviewData(state.resources);
      } else if (state is AuthorsLoading) {
        _isAuthorsLoading = true;
      } else if (state is AuthorsLoaded) {
        _isAuthorsLoading = false;
        authorNames = state.authors;
      } else if (state is ResourceByAuthorsLoading) {
        _isAuthorsResourcesLoading = true;
      } else if (state is ResourceByAuthorsLoaded) {
        _isAuthorsResourcesLoading = false;
        resourcesByAuthors = state.authors;
      } else if (state is ResourceByDepartmentLoading) {
        _isDepartmentsLoading = true;
      } else if (state is ResourceByDepartmentLoaded) {
        _isDepartmentsLoading = false;
        resourcesByDepartment = state.departments;
      } else if (state is ResourceByCategoryLoading) {
        _isPublicationsLoading = true;
      } else if (state is ResourceByCategoryLoaded) {
        _isPublicationsLoading = false;
        resourcesByCategory = state.researches;
      } else if (state is LibraryNewsLoading) {
        _isNewsLoading = true;
      } else if (state is LibraryNewsLoaded) {
        _isNewsLoading = false;
        popularNews = state.news.popularNews;
        latestNews = state.news.latestNews;
      }
    });
  }

  void _processOverviewData(Resource resources) {
    // Process authors
    authorNames =
        resources.authors?.map((author) => author.firstName).toList() ?? [];
    authorLibrary =
        resources.authors
            ?.map((author) => author.resources ?? [])
            .expand((x) => x)
            .toList() ??
        [];

    // Process departments
    departments =
        resources.departments?.map((dept) => dept.name).toList() ?? [];
    departmentsLibrary =
        resources.departments
            ?.map((dept) => dept.resources)
            .expand((x) => x)
            .toList() ??
        [];
    resourcesByDepartment = resources.departments ?? [];

    // Process publications and journals
    journalLibrary =
        resources.research
            ?.where((research) => research.category.toLowerCase() == 'journal')
            .expand((research) => research.resources)
            .toList() ??
        [];
    publicationLibrary =
        resources.research
            ?.where(
              (research) => research.category.toLowerCase() == 'publication',
            )
            .expand((research) => research.resources)
            .toList() ??
        [];

    // Process news
    if (resources.libraryNews != null) {
      popularNews = resources.libraryNews!.popularNews;
      latestNews = resources.libraryNews!.latestNews;
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isOverviewLoading = true;
      _isAuthorsLoading = true;
      _isAuthorsResourcesLoading = true;
      _isDepartmentsLoading = true;
      _isPublicationsLoading = true;
      _isNewsLoading = true;
    });

    final resourceBloc = context.read<ResourceBloc>();
    resourceBloc.add(const RefreshLibraryData());

    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ResourceBloc, ResourceState>(
          listener: (context, state) {
            _updateLoadingStates(state);
            // if (state is ResourceError) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text(state.message)),
            //   );
            // }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const TextField(
            decoration: InputDecoration(
              hintText: 'Search name or author',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            indicator: const BoxDecoration(color: Colors.transparent),
            tabs: tabs.map((tab) => Tab(text: tab)).toList(),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: TabBarView(
            controller: _tabController,
            children: [
              // All Tab
              _buildAllTab(),
              // Authors Tab
              AuthorsTab(
                selectedOption: _selectedOption,
                onOptionSelected: _onOptionSelected,
                authorNames: authorNames,
                resources: resourcesByAuthors
                    .map((author) => author.resources ?? [])
                    .expand((library) => library)
                    .toList(),
              ),
              // Department Tab
              DepartmentTab(departments: resourcesByDepartment),
              // Publications and Journals Tab
              PublicationTab(
                journalLibrary: journalLibrary,
                bookLibrary: publicationLibrary,
              ),
              // News Tab
              NewsTab(
                currentPage: _currentPage,
                latestNews: latestNews,
                popularNews: popularNews,
                onPageChanged: _onPageChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllTab() {
    return ListView(
      children: [
        // Authors Section
        _buildAuthorsSection(),
        // Authors Resources Section
        _buildAuthorsResourcesSection(),
        // Departments Section
        _buildDepartmentsSection(),
        // Publications and Journals Section
        _buildPublicationsSection(),
      ],
    );
  }

  Widget _buildAuthorsSection() {
    final isLoading = _isOverviewLoading || _isAuthorsLoading;
    final authors = isLoading ? List.filled(8, '') : authorNames;

    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeeAllTitle(
            title: 'Authors',
            onPressed: () => _tabController.animateTo(1),
          ),
          AlphabeticalFilter(
            selectedOption: _selectedOption,
            onOptionSelected: _onOptionSelected,
          ),
          const SizedBox(height: 10),
          NameList(authors: authors),
        ],
      ),
    );
  }

  Widget _buildAuthorsResourcesSection() {
    final isLoading = _isOverviewLoading || _isAuthorsResourcesLoading;
    final resources = isLoading
        ? List.generate(
            4,
            (i) => const Library(
              id: '',
              title: '',
              description: '',
              authorId: '',
              departmentId: '',
              documentUrl: '',
              uploaderId: '',
            ),
          )
        : authorLibrary.take(4).toList();

    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: resources
                  .map((resource) => BookCard(title: resource.title))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentsSection() {
    final isLoading = _isOverviewLoading || _isDepartmentsLoading;
    final resources = isLoading
        ? List.generate(
            4,
            (i) => const Library(
              id: '',
              title: '',
              description: '',
              authorId: '',
              departmentId: '',
              documentUrl: '',
              uploaderId: '',
            ),
          )
        : departmentsLibrary.take(4).toList();

    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeeAllTitle(
            title: 'Departments',
            onPressed: () => _tabController.animateTo(2),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: resources
                  .map((resource) => BookCard(title: resource.title))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPublicationsSection() {
    final isLoading = _isOverviewLoading || _isPublicationsLoading;
    final resources = isLoading
        ? List.generate(
            4,
            (i) => const Library(
              id: '',
              title: '',
              description: '',
              authorId: '',
              departmentId: '',
              documentUrl: '',
              uploaderId: '',
            ),
          )
        : [...journalLibrary, ...publicationLibrary].take(4).toList();

    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeeAllTitle(
            title: 'Publications and Journals',
            onPressed: () => _tabController.animateTo(3),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: resources
                  .map((resource) => BookCard(title: resource.title))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
