import 'package:esl/features/my_course/domain/entities/enrollment_reference.dart';

class EnrollmentReferenceModel extends EnrollmentReference {
  const EnrollmentReferenceModel({
    super.id,
    super.title,
    super.institution,
    super.contactNumber,
  });

  factory EnrollmentReferenceModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentReferenceModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      institution: json['institution'] as String?,
      contactNumber: json['contactNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'institution': institution,
      'contactNumber': contactNumber,
    };
  }

  factory EnrollmentReferenceModel.fromEntity(EnrollmentReference entity) {
    return EnrollmentReferenceModel(
      id: entity.id,
      title: entity.title,
      institution: entity.institution,
      contactNumber: entity.contactNumber,
    );
  }

  EnrollmentReference toEntity() {
    return EnrollmentReference(
      id: id,
      title: title,
      institution: institution,
      contactNumber: contactNumber,
    );
  }
}
