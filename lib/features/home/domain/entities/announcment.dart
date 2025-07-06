import 'package:equatable/equatable.dart';

class Announcment extends Equatable {
  final String? title;
  final String? description;

  const Announcment({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description];
}
