part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object> get props => [];
}

class GetGallery extends GalleryEvent {
  const GetGallery();

  @override
  List<Object> get props => [];
}

class RefreshGallery extends GalleryEvent {
  const RefreshGallery();

  @override
  List<Object> get props => [];
}
