import 'package:equatable/equatable.dart';

class EmploymentHistory extends Equatable {
  final String? id;
  final String? jobTitle;
  final String? companyName;
  final String? employmentType;
  final String? statedDate;
  final String? endDate;
  final bool? isCurrentJob;

  const EmploymentHistory({
    this.id,
    this.jobTitle,
    this.companyName,
    this.employmentType,
    this.statedDate,
    this.endDate,
    this.isCurrentJob,
  });

  @override
  List<Object?> get props => [
    id,
    jobTitle,
    companyName,
    employmentType,
    statedDate,
    endDate,
    isCurrentJob,
  ];
}
