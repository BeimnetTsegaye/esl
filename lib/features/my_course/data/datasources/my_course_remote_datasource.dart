import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/features/my_course/data/datasources/my_course_endpoints.dart';
import 'package:esl/features/my_course/data/models/enrolled_program_model.dart';
import 'package:esl/features/my_course/data/models/grade_model.dart';
import 'package:esl/features/my_course/domain/entities/weekly_schedule.dart';

abstract class MyCourseRemoteDataSource {
  Future<List<EnrolledProgramModel>> getEnrolledProgram();
  Future<GradeModel> getGrade({String? semester});
  Future<WeeklySchedule> getWeeklySchedule();
}

class MyCourseRemoteDataSourceImpl implements MyCourseRemoteDataSource {
  final DioClient dioClient;

  MyCourseRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<GradeModel> getGrade({String? semester}) async {
    try {
      final response = await dioClient.get(
        MyCourseEndpoints.myCourses,
        queryParameters: semester != null ? {'semester': semester} : null,
        fromJsonT: (json) => GradeModel.fromJson(json as Map<String, dynamic>),
      );
      if (!response.success) {
        throw Exception(response.message);
      }
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WeeklySchedule> getWeeklySchedule() async {
    try {
      final response = await dioClient.get(
        MyCourseEndpoints.weeklySchedule,
        fromJsonT: (json) =>
            WeeklySchedule.fromJson(json as Map<String, dynamic>),
      );
      if (!response.success) {
        throw Exception(response.message);
      }
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<List<EnrolledProgramModel>> getEnrolledProgram() async {
    try {
      final response = await dioClient.get(
        MyCourseEndpoints.enrolledProgram,
        fromJsonT: (json) => (json as List)
            .map((item) => EnrolledProgramModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
      if (!response.success) {
        throw Exception(response.message);
      }
      return response.data!;
    } catch (e) {
      rethrow;
    }
  }
}
