import 'package:equatable/equatable.dart';

class EducationalBackground extends Equatable {
  final String? id;
  final String? instituteName;
  final String? qualification;
  final String? fieldOfStudy;
  final String? statedDate;
  final String? endDate;
  final String? certificate;

  const EducationalBackground({this.id, this.instituteName, this.qualification, this.fieldOfStudy, this.statedDate, this.endDate, this.certificate});

  @override
  List<Object?> get props => [id, instituteName, qualification, fieldOfStudy, statedDate, endDate, certificate];
}
