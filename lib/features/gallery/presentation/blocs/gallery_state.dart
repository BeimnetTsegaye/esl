part of 'gallery_bloc.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object> get props => [];
}

class GalleryInitial extends GalleryState {}

class GalleryLoading extends GalleryState {}

class GalleryLoaded extends GalleryState {
  final List<Gallery> galleries;

  const GalleryLoaded(this.galleries);

  @override
  List<Object> get props => [galleries];
}

class GalleryError extends GalleryState {
  final String message;

  const GalleryError(this.message);

  @override
  List<Object> get props => [message];
}

class GalleryEmpty extends GalleryState {
  final String message;

  const GalleryEmpty(this.message);

  @override
  List<Object> get props => [message];
}
