import 'package:equatable/equatable.dart';

class RequiredDocument extends Equatable {
  final String? id;
  final String? name;
  final Map<String, dynamic>? description;
  final String? document;

  const RequiredDocument({this.id, this.name, this.description, this.document});

  @override
  List<Object?> get props => [id, name, description, document];
}
