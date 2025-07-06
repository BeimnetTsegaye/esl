import 'package:equatable/equatable.dart';

class EnrollmentReference extends Equatable {
  final String? id;
  final String? title;
  final String? institution;
  final String? contactNumber;

  const EnrollmentReference({
    this.id,
    this.title,
    this.institution,
    this.contactNumber,
  });

  @override
  List<Object?> get props => [id, title, institution, contactNumber];
}
