import 'package:esl/features/my_course/domain/entities/employment_history.dart';

class EmploymentHistoryModel extends EmploymentHistory {
  const EmploymentHistoryModel({
    super.id,
    super.jobTitle,
    super.companyName,
    super.employmentType,
    super.statedDate,
    super.endDate,
    super.isCurrentJob,
  });

  factory EmploymentHistoryModel.fromJson(Map<String, dynamic> json) {
    return EmploymentHistoryModel(
      id: json['id'] as String?,
      jobTitle: json['jobTitle'] as String?,
      companyName: json['companyName'] as String?,
      employmentType: json['employmentType'] as String?,
      statedDate: json['statedDate'] as String?,
      endDate: json['endDate'] as String?,
      isCurrentJob: json['isCurrentJob'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobTitle': jobTitle,
      'companyName': companyName,
      'employmentType': _parseEmploymentType(employmentType),
      'statedDate': statedDate,
      'endDate': endDate,
      'isCurrentJob': isCurrentJob ?? false,
    };
  }

  factory EmploymentHistoryModel.fromEntity(EmploymentHistory entity) {
    return EmploymentHistoryModel(
      id: entity.id,
      jobTitle: entity.jobTitle,
      companyName: entity.companyName,
      employmentType: entity.employmentType,
      statedDate: entity.statedDate,
      endDate: entity.endDate,
      isCurrentJob: entity.isCurrentJob ?? false,
    );
  }

  EmploymentHistory toEntity() {
    return EmploymentHistory(
      id: id,
      jobTitle: jobTitle,
      companyName: companyName,
      employmentType: employmentType,
      statedDate: statedDate,
      endDate: endDate,
      isCurrentJob: isCurrentJob ?? false,
    );
  }

  String? _parseEmploymentType(String? employmentType) {
    if (employmentType == null) return null;
    
    switch (employmentType.toLowerCase()) {
      case 'full time':
      case 'fulltime':
        return 'FullTime';
      case 'part time':
      case 'parttime':
        return 'PartTime';
      case 'internship':
        return 'Internship';
      case 'freelance':
        return 'Freelance';
      case 'contract':
        return 'Contract';
      default:
        return 'FullTime'; // Default fallback
    }
  }
}
