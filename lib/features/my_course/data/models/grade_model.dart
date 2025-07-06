import 'package:esl/features/my_course/data/models/course_model.dart';
import 'package:esl/features/my_course/domain/entities/grade.dart';

class GradeModel extends Grade {
  const GradeModel({required super.courses, required super.totalMark});

  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      courses: (json['coursesThisSemester'] as List)
          .map((course) => CourseModel.fromJson(course as Map<String, dynamic>))
          .toList(),
      totalMark: (json['totalMark'] as num).toDouble(),
    );
  }

  Grade toEntity() {
    return Grade(courses: courses, totalMark: totalMark);
  }
}
