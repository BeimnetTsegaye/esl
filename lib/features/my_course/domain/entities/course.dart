class Course {
  final String? id;
  final String? title;
  final Map<String, dynamic>? description;
  final String? programId;
  final String? courseCode;
  final String? duration;
  final int? creditHours;
  final String? instructorId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? curriculum;
  final String? eligibilityCriterion;
  final String? educationalQualification;
  final String? requiredDocuments;
  final CourseGrade? courseGrade;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.programId,
    required this.courseCode,
    required this.duration,
    required this.creditHours,
    required this.instructorId,
    required this.startDate,
    required this.endDate,
    required this.curriculum,
    required this.eligibilityCriterion,
    this.educationalQualification,
    required this.requiredDocuments,
    this.courseGrade,
  });
}

class CourseGrade {
  final String mark;
  final String pass;

  CourseGrade({required this.mark, required this.pass});

  factory CourseGrade.fromJson(Map<String, dynamic> json) {
    return CourseGrade(
      mark: json['mark'] as String? ?? '',
      pass: json['pass'] as String? ?? '',
    );
  }
}
