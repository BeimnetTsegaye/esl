part of 'my_course_bloc.dart';

abstract class MyCourseState extends Equatable {
  const MyCourseState();

  @override
  List<Object> get props => [];
}

class MyCourseInitial extends MyCourseState {}

class MyCourseLoading extends MyCourseState {}

class MyCourseLoaded extends MyCourseState {
  final Grade grade;

  const MyCourseLoaded({required this.grade});

  @override
  List<Object> get props => [grade];
}

class MyCourseError extends MyCourseState {
  final String message;

  const MyCourseError({required this.message});

  @override
  List<Object> get props => [message];
}

class EnrolledProgramLoaded extends MyCourseState {
  final List<EnrolledProgramModel> myPrograms;

  const EnrolledProgramLoaded({required this.myPrograms});

  @override
  List<Object> get props => [myPrograms];
}

class EnrolledProgramError extends MyCourseState {
  final String message;

  const EnrolledProgramError({required this.message});

  @override
  List<Object> get props => [message];
}

class EnrolledProgramLoading extends MyCourseState {
  final List<EnrolledProgramModel> fakePrograms = List.generate(
    5,
    (index) => EnrolledProgramModel(
      applicationState: ApplicationStatus.PENDING,
      program: Program(
        id: index.toString(),
        name: 'Program $index',
        programImage: '',
      ),
    ),
  );
  EnrolledProgramLoading();

  @override
  List<Object> get props => [fakePrograms];
}

class WeeklyScheduleLoaded extends MyCourseState {
  final WeeklySchedule weeklySchedule;

  const WeeklyScheduleLoaded({required this.weeklySchedule});

  @override
  List<Object> get props => [weeklySchedule];
}

class WeeklyScheduleError extends MyCourseState {
  final String message;

  const WeeklyScheduleError({required this.message});

  @override
  List<Object> get props => [message];
}

class WeeklyScheduleLoading extends MyCourseState {
  const WeeklyScheduleLoading();

  @override
  List<Object> get props => [];
}
