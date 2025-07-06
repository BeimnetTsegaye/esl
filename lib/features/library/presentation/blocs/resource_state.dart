part of 'resource_bloc.dart';

abstract class ResourceState extends Equatable {
  const ResourceState();

  @override
  List<Object> get props => [];
}

class ResourceInitial extends ResourceState {}

class ResourceLoading extends ResourceState {}

class ResourceLoaded extends ResourceState {
  final Resource resources;

  const ResourceLoaded({required this.resources});

  @override
  List<Object> get props => [resources];
}

class ResourceError extends ResourceState {
  final String message;

  const ResourceError({required this.message});

  @override
  List<Object> get props => [message];
}

class ResourceEmpty extends ResourceState {
  const ResourceEmpty();

  @override
  List<Object> get props => [];
}

class AuthorsLoading extends ResourceState {
  final List<String> fakeAuthors = [
    'Loading...',
    'Please wait...',
    'Fetching authors...',
  ];

  AuthorsLoading();

  @override
  List<Object> get props => [fakeAuthors];
}

class AuthorsLoaded extends ResourceState {
  final List<String> authors;

  const AuthorsLoaded({required this.authors});

  @override
  List<Object> get props => [authors];
}

class AuthorsError extends ResourceState {
  final String message;

  const AuthorsError({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthorsEmpty extends ResourceState {
  const AuthorsEmpty();

  @override
  List<Object> get props => [];
}

class ResourceByAuthorsLoading extends ResourceState {
  final List<Author> fakeAuthors = List.generate(
    10,
    (index) => const Author(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      resources: [
        Library(
          id: '1',
          title: 'Sample Resource',
          description: 'A sample resource description',
          authorId: '1',
          departmentId: '1',
          documentUrl: 'http://example.com/resource.pdf',
          uploaderId: '1',
        ),
      ],
    ),
  );
  ResourceByAuthorsLoading();

  @override
  List<Object> get props => [fakeAuthors];
}

class ResourceByAuthorsLoaded extends ResourceState {
  final List<Author> authors;

  const ResourceByAuthorsLoaded({required this.authors});

  @override
  List<Object> get props => [authors];
}

class ResourceByDepartmentLoading extends ResourceState {
  final List<Department> fakeDepartments = List.generate(
    10,
    (index) => Department(
      id: '1',
      name: 'Computer Science',
      departmentId: '',
      facultyId: '',
      description: DepartmentDescription(
        mission: 'Mission',
        vision: 'Vision',
        head: DepartmentHead(name: 'John Doe', email: 'john.doe@example.com'),
      ),
      imageUrl: 'http://example.com/image.jpg',
      resources: [
        const Library(
          id: '1',
          title: 'Introduction to Algorithms',
          description: 'A comprehensive guide to algorithms.',
          authorId: '1',
          departmentId: '1',
          documentUrl: 'http://example.com/algorithms.pdf',
          uploaderId: '1',
        ),
      ],
    ),
  );

  ResourceByDepartmentLoading();

  @override
  List<Object> get props => [fakeDepartments];
}

class ResourceByDepartmentLoaded extends ResourceState {
  final List<Department> departments;

  const ResourceByDepartmentLoaded({required this.departments});

  @override
  List<Object> get props => [departments];
}

class ResourceByCategoryLoading extends ResourceState {
  final List<Research> fakeResearches = [
    const Research(
      category: 'JOURNAL',
      resources: [
        Library(
          id: '2',
          title: 'Advanced Mathematics',
          description: 'A book on advanced mathematics.',
          authorId: '2',
          departmentId: '2',
          documentUrl: '',
          uploaderId: '2',
        ),
        Library(
          id: '2',
          title: 'Advanced Mathematics',
          description: 'A book on advanced mathematics.',
          authorId: '2',
          departmentId: '2',
          documentUrl: '',
          uploaderId: '2',
        ),
        Library(
          id: '2',
          title: 'Advanced Mathematics',
          description: 'A book on advanced mathematics.',
          authorId: '2',
          departmentId: '2',
          documentUrl: '',
          uploaderId: '2',
        ),
        Library(
          id: '1',
          title: 'Journal of Computer Science',
          description: 'A journal on computer science research.',
          authorId: '1',
          departmentId: '1',
          documentUrl: '',
          uploaderId: '1',
        ),
      ],
    ),
    const Research(
      category: 'PUBLICATION',
      resources: [
        Library(
          id: '2',
          title: 'Advanced Mathematics',
          description: 'A book on advanced mathematics.',
          authorId: '2',
          departmentId: '2',
          documentUrl: 'http://example.com/book1.pdf',
          uploaderId: '2',
        ),
        Library(
          id: '2',
          title: 'Advanced Mathematics',
          description: 'A book on advanced mathematics.',
          authorId: '2',
          departmentId: '2',
          documentUrl: 'http://example.com/book1.pdf',
          uploaderId: '2',
        ),
        Library(
          id: '2',
          title: 'Advanced Mathematics',
          description: 'A book on advanced mathematics.',
          authorId: '2',
          departmentId: '2',
          documentUrl: 'http://example.com/book1.pdf',
          uploaderId: '2',
        ),
        Library(
          id: '2',
          title: 'Advanced Mathematics',
          description: 'A book on advanced mathematics.',
          authorId: '2',
          departmentId: '2',
          documentUrl: 'http://example.com/book1.pdf',
          uploaderId: '2',
        ),
      ],
    ),
  ];

  ResourceByCategoryLoading();

  @override
  List<Object> get props => [fakeResearches];
}

class ResourceByCategoryLoaded extends ResourceState {
  final List<Research> researches;

  const ResourceByCategoryLoaded({required this.researches});

  @override
  List<Object> get props => [researches];
}

class LibraryNewsLoading extends ResourceState {
  final LibraryNews fakeNews = LibraryNews(
    popularNews: List.generate(
      10,
      (index) => const News(
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
    ),
    latestNews: List.generate(
      10,
      (index) => const News(
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
    ),
  );

  LibraryNewsLoading();

  @override
  List<Object> get props => [fakeNews];
}

class LibraryNewsLoaded extends ResourceState {
  final LibraryNews news;

  const LibraryNewsLoaded({required this.news});

  @override
  List<Object> get props => [news];
}
