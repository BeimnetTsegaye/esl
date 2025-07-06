import 'package:equatable/equatable.dart';
import 'package:esl/core/shared/usecase.dart';
import 'package:esl/features/home/domain/entities/news.dart';
import 'package:esl/features/library/domain/entities/author.dart';
import 'package:esl/features/library/domain/entities/department.dart';
import 'package:esl/features/library/domain/entities/library.dart';
import 'package:esl/features/library/domain/entities/library_news.dart';
import 'package:esl/features/library/domain/entities/research.dart';
import 'package:esl/features/library/domain/entities/resource.dart';
import 'package:esl/features/library/domain/usecases/get_authors_usecase.dart';
import 'package:esl/features/library/domain/usecases/get_library_news_usecase.dart';
import 'package:esl/features/library/domain/usecases/get_resource_by_authors_usecase.dart';
import 'package:esl/features/library/domain/usecases/get_resource_by_category_usecase.dart';
import 'package:esl/features/library/domain/usecases/get_resource_by_department_usecase.dart';
import 'package:esl/features/library/domain/usecases/get_resources_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'resource_event.dart';
part 'resource_state.dart';

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final GetResourcesUseCase _getResourcesUseCase;
  final GetAuthorsUseCase _getAuthorsUseCase;
  final GetResourceByAuthorsUseCase _getResourceByAuthorsUseCase;
  final GetResourceByDepartmentUseCase _getResourceByDepartmentUseCase;
  final GetResourceByCategoryUseCase _getResourceByCategoryUseCase;
  final GetLibraryNewsUseCase _getLibraryNewsUseCase;

  // Cache for different states
  ResourceState? _resourcesState;
  ResourceState? _authorsState;
  ResourceState? _resourceByAuthorsState;
  ResourceState? _resourceByDepartmentState;
  ResourceState? _resourceByCategoryState;
  ResourceState? _libraryNewsState;

  ResourceBloc({
    required GetResourcesUseCase getResourcesUseCase,
    required GetAuthorsUseCase getAuthorsUseCase,
    required GetResourceByCategoryUseCase getResourceByCategoryUseCase,
    required GetResourceByAuthorsUseCase getResourceByAuthorsUseCase,
    required GetResourceByDepartmentUseCase getResourceByDepartmentUseCase,
    required GetLibraryNewsUseCase getLibraryNewsUseCase,
  }) : _getResourcesUseCase = getResourcesUseCase,
       _getAuthorsUseCase = getAuthorsUseCase,
       _getResourceByCategoryUseCase = getResourceByCategoryUseCase,
       _getResourceByAuthorsUseCase = getResourceByAuthorsUseCase,
       _getResourceByDepartmentUseCase = getResourceByDepartmentUseCase,
       _getLibraryNewsUseCase = getLibraryNewsUseCase,
       super(ResourceInitial()) {
    on<GetResources>(_onGetResources);
    on<GetAuthors>(_onGetAuthors);
    on<GetResourceByAuthors>(_onGetResourceByAuthors);
    on<GetResourceByDepartment>(_onGetResourceByDepartment);
    on<GetResourceByCategory>(_onGetResourceByCategory);
    on<GetLibraryNews>(_onGetLibraryNews);
    on<RefreshLibraryData>(_onRefreshLibraryData);
  }

  // Method to clear all cached states
  void _clearCache() {
    _resourcesState = null;
    _authorsState = null;
    _resourceByAuthorsState = null;
    _resourceByDepartmentState = null;
    _resourceByCategoryState = null;
    _libraryNewsState = null;
  }

  Future<void> _onRefreshLibraryData(
    RefreshLibraryData event,
    Emitter<ResourceState> emit,
  ) async {
    // Clear all cached states
    _clearCache();
    
    // Emit loading state
    emit(ResourceLoading());
    
    // Reload all data
    try {
      await Future.wait([
        _getResourcesUseCase(NoParams()),
        _getAuthorsUseCase(NoParams()),
        _getResourceByAuthorsUseCase(NoParams()),
        _getResourceByDepartmentUseCase(NoParams()),
        _getResourceByCategoryUseCase(NoParams()),
        _getLibraryNewsUseCase(NoParams()),
      ]);
      
      // After all data is loaded, emit the main resources state
      final result = await _getResourcesUseCase(NoParams());
      result.fold(
        (left) {
          final errorState = ResourceError(
            message: left.message ?? 'Failed to refresh library data',
          );
          emit(errorState);
        },
        (resources) {
          final loadedState = ResourceLoaded(resources: resources);
          _resourcesState = loadedState;
          emit(loadedState);
        },
      );
    } catch (e) {
      final errorState = ResourceError(message: 'Failed to refresh: $e');
      emit(errorState);
    }
  }

  Future<void> _onGetResources(
    GetResources event,
    Emitter<ResourceState> emit,
  ) async {
    // Return cached state if available
    if (_resourcesState != null && _resourcesState is ResourceLoaded) {
      emit(_resourcesState!);
      return;
    }

    emit(ResourceLoading());
    try {
      await _getResourcesUseCase(NoParams()).then((result) {
        return result.fold(
          (left) {
            final errorState = ResourceError(
              message: left.message ?? 'Failed to fetch resources {at ResourceBloc}',
            );
            _resourcesState = errorState;
            emit(errorState);
          },
          (resources) {
            final loadedState = ResourceLoaded(resources: resources);
            _resourcesState = loadedState;
            emit(loadedState);
            return resources;
          },
        );
      });
    } catch (e) {
      final errorState = ResourceError(message: e.toString());
      _resourcesState = errorState;
      emit(errorState);
    }
  }

  Future<void> _onGetAuthors(
    GetAuthors event,
    Emitter<ResourceState> emit,
  ) async {
    // Return cached state if available
    if (_authorsState != null && _authorsState is AuthorsLoaded) {
      emit(_authorsState!);
      return;
    }

    emit(AuthorsLoading());
    try {
      await _getAuthorsUseCase(NoParams()).then((result) {
        return result.fold(
          (left) {
            final errorState = AuthorsError(message: left.message ?? 'Failed to fetch authors');
            _authorsState = errorState;
            emit(errorState);
          },
          (authors) {
            if (authors.isEmpty) {
              const emptyState = AuthorsEmpty();
              _authorsState = emptyState;
              emit(emptyState);
              return [];
            }
            final List<String> authorNames = authors.map((author) => author.firstName).toList();
            final loadedState = AuthorsLoaded(authors: authorNames);
            _authorsState = loadedState;
            emit(loadedState);
            return authors;
          },
        );
      });
    } catch (e) {
      final errorState = AuthorsError(message: e.toString());
      _authorsState = errorState;
      emit(errorState);
    }
  }

  Future<void> _onGetResourceByAuthors(
    GetResourceByAuthors event,
    Emitter<ResourceState> emit,
  ) async {
    // Return cached state if available
    if (_resourceByAuthorsState != null && _resourceByAuthorsState is ResourceByAuthorsLoaded) {
      emit(_resourceByAuthorsState!);
      return;
    }

    emit(ResourceByAuthorsLoading());
    try {
      await _getResourceByAuthorsUseCase(NoParams()).then((result) {
        return result.fold(
          (left) {
            final errorState = ResourceError(
              message: left.message ?? 'Failed to fetch resources by authors',
            );
            _resourceByAuthorsState = errorState;
            emit(errorState);
          },
          (resources) {
            final loadedState = ResourceByAuthorsLoaded(authors: resources);
            _resourceByAuthorsState = loadedState;
            emit(loadedState);
            return resources;
          },
        );
      });
    } catch (e) {
      final errorState = ResourceError(message: e.toString());
      _resourceByAuthorsState = errorState;
      emit(errorState);
    }
  }

  Future<void> _onGetResourceByDepartment(
    GetResourceByDepartment event,
    Emitter<ResourceState> emit,
  ) async {
    // Return cached state if available
    if (_resourceByDepartmentState != null && _resourceByDepartmentState is ResourceByDepartmentLoaded) {
      emit(_resourceByDepartmentState!);
      return;
    }

    emit(ResourceByDepartmentLoading());
    try {
      await _getResourceByDepartmentUseCase(NoParams()).then((result) {
        return result.fold(
          (left) {
            final errorState = ResourceError(
              message: left.message ?? 'Failed to fetch resources by department',
            );
            _resourceByDepartmentState = errorState;
            emit(errorState);
          },
          (resources) {
            final loadedState = ResourceByDepartmentLoaded(departments: resources);
            _resourceByDepartmentState = loadedState;
            emit(loadedState);
            return resources;
          },
        );
      });
    } catch (e) {
      final errorState = ResourceError(message: e.toString());
      _resourceByDepartmentState = errorState;
      emit(errorState);
    }
  }

  Future<void> _onGetResourceByCategory(
    GetResourceByCategory event,
    Emitter<ResourceState> emit,
  ) async {
    // Return cached state if available
    if (_resourceByCategoryState != null && _resourceByCategoryState is ResourceByCategoryLoaded) {
      emit(_resourceByCategoryState!);
      return;
    }

    emit(ResourceByCategoryLoading());
    try {
      await _getResourceByCategoryUseCase(NoParams()).then((result) {
        return result.fold(
          (left) {
            final errorState = ResourceError(
              message: left.message ?? 'Failed to fetch resources by category',
            );
            _resourceByCategoryState = errorState;
            emit(errorState);
          },
          (resources) {
            final loadedState = ResourceByCategoryLoaded(researches: resources);
            _resourceByCategoryState = loadedState;
            emit(loadedState);
            return resources;
          },
        );
      });
    } catch (e) {
      final errorState = ResourceError(message: e.toString());
      _resourceByCategoryState = errorState;
      emit(errorState);
    }
  }

  Future<void> _onGetLibraryNews(
    GetLibraryNews event,
    Emitter<ResourceState> emit,
  ) async {
    // Return cached state if available
    if (_libraryNewsState != null && _libraryNewsState is LibraryNewsLoaded) {
      emit(_libraryNewsState!);
      return;
    }

    emit(LibraryNewsLoading());
    final result = await _getLibraryNewsUseCase(NoParams());
    result.fold(
      (failure) {
        final errorState = ResourceError(message: failure.message ?? 'Failed to fetch news');
        _libraryNewsState = errorState;
        emit(errorState);
      },
      (news) {
        final loadedState = LibraryNewsLoaded(news: news);
        _libraryNewsState = loadedState;
        emit(loadedState);
      },
    );
  }
}
