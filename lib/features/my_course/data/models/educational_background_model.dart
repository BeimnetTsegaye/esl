import 'package:esl/features/my_course/domain/entities/educational_background.dart';

class EducationalBackgroundModel extends EducationalBackground {
  const EducationalBackgroundModel({
    super.id,
    super.instituteName,
    super.qualification,
    super.fieldOfStudy,
    super.statedDate,
    super.endDate,
    super.certificate,
  });

  factory EducationalBackgroundModel.fromJson(Map<String, dynamic> json) {
    return EducationalBackgroundModel(
      id: json['id'] as String?,
      instituteName: json['instituteName'] as String?,
      qualification: json['qualification'] as String?,
      fieldOfStudy: json['fieldOfStudy'] as String?,
      statedDate: json['statedDate'] as String?,
      endDate: json['endDate'] as String?,
      certificate: json['certificate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'instituteName': instituteName,
      'qualification': qualification,
      'fieldOfStudy': fieldOfStudy,
      'statedDate': statedDate,
      'endDate': endDate,
    };
  }

  factory EducationalBackgroundModel.fromEntity(EducationalBackground entity) {
    return EducationalBackgroundModel(
      id: entity.id,
      instituteName: entity.instituteName,
      qualification: entity.qualification,
      fieldOfStudy: entity.fieldOfStudy,
      statedDate: entity.statedDate,
      endDate: entity.endDate,
      certificate: entity.certificate,
    );
  }

  EducationalBackground toEntity() {
    return EducationalBackground(
      id: id,
      instituteName: instituteName,
      qualification: qualification,
      fieldOfStudy: fieldOfStudy,
      statedDate: statedDate,
      endDate: endDate,
      certificate: certificate,
    );
  }
}
