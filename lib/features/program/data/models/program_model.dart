import 'package:esl/features/my_course/data/models/course_model.dart';
import 'package:esl/features/my_course/data/models/required_document_model.dart';
import 'package:esl/features/program/data/models/criteria_model.dart';
import 'package:esl/features/program/data/models/director_model.dart';
import 'package:esl/features/program/domain/entities/program.dart';

class ProgramModel extends Program {
  const ProgramModel({
    required super.id,
    required super.programCode,
    required super.name,
    required super.description,
    required super.director,
    required super.programImage,
    required super.price,
    required super.passPoint,
    required super.directorId,
    required super.courses,
    required super.eligibilityCriteria,
    required super.requiredDocuments,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    // Handle description field - it can be a JSON string or object
    String? description;
    if (json['description'] != null) {
      if (json['description'] is String) {
        description = json['description'] as String;
      } else if (json['description'] is Map<String, dynamic>) {
        description = json['description'].toString();
      }
    }

    return ProgramModel(
      id: json['id'] as String? ?? '',
      programImage: json['programImage'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: description,
      director: json['director'] != null 
          ? DirectorModel.fromJson(json['director'] as Map<String, dynamic>).toEntity()
          : null,
      directorId: json['directorId'] as String? ?? '',
      courses: (json['courses'] as List<dynamic>? ?? [])
          .map(
            (e) => CourseModel.fromJson(e as Map<String, dynamic>).toEntity(),
          )
          .toList(),
      eligibilityCriteria: (json['criteria'] as List<dynamic>? ?? [])
          .map(
            (e) => EligibilityCriteriaModel.fromJson(
              e as Map<String, dynamic>,
            ).toEntity(),
          )
          .toList(),
      passPoint: json['passPoint'] as int? ?? 0,
      price: json['price'] as String? ?? '',
      programCode: json['programCode'] as String? ?? '',
      requiredDocuments: (json['requiredDocuments'] as List<dynamic>? ?? [])
          .map(
            (e) => RequiredDocumentModel.fromJson(
              e as Map<String, dynamic>,
            ).toEntity(),
          )
          .toList(),
    );
  }

  Program toEntity() {
    return Program(
      id: id,
      name: name,
      description: description, 
      programImage: programImage,
      director: director,
      directorId: directorId,
      courses: courses,
      eligibilityCriteria: eligibilityCriteria,
      passPoint: passPoint,
      price: price,
      programCode: programCode,
      requiredDocuments: requiredDocuments,
    );
  }
}
