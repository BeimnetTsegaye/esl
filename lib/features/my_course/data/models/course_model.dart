import 'dart:convert';

import 'package:esl/features/my_course/domain/entities/course.dart';

class CourseModel extends Course {
  CourseModel({
    required super.id,
    required super.title,
    required super.description,
    required super.programId,
    required super.courseCode,
    required super.duration,
    required super.creditHours,
    required super.instructorId,
    required super.startDate,
    required super.endDate,
    required super.curriculum,
    required super.eligibilityCriterion,
    super.educationalQualification,
    required super.requiredDocuments,
    super.courseGrade,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? description;
    if (json['description'] != null) {
      if (json['description'] is String) {
        try {
          description =
              jsonDecode(json['description'] as String) as Map<String, dynamic>;
        } catch (e) {
          description = {'text': json['description'] as String};
        }
      } else if (json['description'] is Map<String, dynamic>) {
        description = json['description'] as Map<String, dynamic>;
      }
    }

    return CourseModel(
      id: json['id'] as String? ?? '',
      title: json['name'] as String? ?? '',
      description: description,
      programId: json['programId'] as String?,
      courseCode: json['course_id'] as String?,
      duration: json['duration'] as String?,
      creditHours: json['creditHours'] as int?,
      instructorId: json['InstructorId'] as String?,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      curriculum: json['curriculum'] as String?,
      eligibilityCriterion: json['eligibilityCriterion'] as String?,
      educationalQualification: json['educationalQualification'] as String?,
      requiredDocuments: json['requiredDocuments'] as String?,
      courseGrade: json['courseGrade'] != null
          ? CourseGrade.fromJson(json['courseGrade'] as Map<String, dynamic>)
          : null,
    );
  }

  Course toEntity() {
    return Course(
      id: id,
      title: title,
      description: description,
      programId: programId,
      courseCode: courseCode,
      startDate: startDate,
      endDate: endDate,
      curriculum: curriculum,
      eligibilityCriterion: eligibilityCriterion,
      educationalQualification: educationalQualification,
      requiredDocuments: requiredDocuments,
      duration: duration,
      creditHours: creditHours,
      instructorId: instructorId,
      courseGrade: courseGrade != null
          ? CourseGrade(mark: courseGrade!.mark, pass: courseGrade!.pass)
          : null,
    );
  }
}
