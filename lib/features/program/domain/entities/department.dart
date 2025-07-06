import 'package:esl/features/my_course/domain/entities/course.dart';

class Department {
  final String id;
  final String name;
  final String facultyId;
  final String batch;
  final Course? course;

  Department({
    required this.name,
    required this.facultyId,
    required this.batch,
    this.course,
    required this.id,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] as String,
      name: json['name'] as String,
      facultyId: '',
      batch: '',
    );
  }
}
