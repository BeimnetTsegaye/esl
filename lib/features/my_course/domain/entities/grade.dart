import 'package:equatable/equatable.dart';
import 'package:esl/features/my_course/domain/entities/course.dart';

class Grade extends Equatable {
  final List<Course> courses;
  final double totalMark;

  const Grade({required this.courses, required this.totalMark});

  @override
  List<Object?> get props => [courses, totalMark];
}
