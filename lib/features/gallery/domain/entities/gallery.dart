import 'package:equatable/equatable.dart';
import 'package:esl/features/gallery/data/models/gallery_model.dart';

class Gallery extends Equatable {
  final String category;
  final List<GalleryItems> items;

  const Gallery({required this.category, required this.items});

  @override
  List<Object?> get props => [category, items];
}
