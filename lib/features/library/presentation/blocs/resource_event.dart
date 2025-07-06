part of 'resource_bloc.dart';

abstract class ResourceEvent extends Equatable {
  const ResourceEvent();

  @override
  List<Object> get props => [];
}

class GetResources extends ResourceEvent {
  const GetResources();

  @override
  List<Object> get props => [];
}

class GetAuthors extends ResourceEvent {
  const GetAuthors();

  @override
  List<Object> get props => [];
}

class GetResourceByAuthors extends ResourceEvent {
  const GetResourceByAuthors();

  @override
  List<Object> get props => [];
}

class GetResourceByDepartment extends ResourceEvent {
  const GetResourceByDepartment();

  @override
  List<Object> get props => [];
}

class GetResourceByCategory extends ResourceEvent {
  const GetResourceByCategory();

  @override
  List<Object> get props => [];
}

class GetLibraryNews extends ResourceEvent {
  const GetLibraryNews();

  @override
  List<Object> get props => [];
}

class RefreshLibraryData extends ResourceEvent {
  const RefreshLibraryData();

  @override
  List<Object> get props => [];
}
