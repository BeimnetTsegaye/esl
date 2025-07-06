import 'package:equatable/equatable.dart';
import 'package:esl/features/auth/domain/entities/user.dart';

class Director extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final User? user;

  const Director({
    this.id,
    this.title,
    this.description,
    this.user,
  });

  @override
  List<Object?> get props => [id, title, description, user];
}
