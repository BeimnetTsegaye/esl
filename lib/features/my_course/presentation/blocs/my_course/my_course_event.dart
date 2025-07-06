part of 'my_course_bloc.dart';

abstract class MyCourseEvent extends Equatable {
  const MyCourseEvent();

  @override
  List<Object> get props => [];
}

class GetEnrolledProgramEvent extends MyCourseEvent {
  const GetEnrolledProgramEvent();

  @override
  List<Object> get props => [];
}

class GetGradeEvent extends MyCourseEvent {
  final String? semester;

  const GetGradeEvent({this.semester});

  @override
  List<Object> get props => [semester ?? ''];
}

class RefreshEnrolledProgramEvent extends MyCourseEvent {
  const RefreshEnrolledProgramEvent();

  @override
  List<Object> get props => [];
}

class GetWeeklyScheduleEvent extends MyCourseEvent {
  const GetWeeklyScheduleEvent();

  @override
  List<Object> get props => [];
}
