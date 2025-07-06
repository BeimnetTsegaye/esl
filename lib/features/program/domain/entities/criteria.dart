import 'package:equatable/equatable.dart';

class EligibilityCriteria extends Equatable {
  final String? id;
  final String? title;
  final String? description;

  const EligibilityCriteria({this.id, this.title, this.description});

  @override
  List<Object?> get props => [id, title, description];
}
