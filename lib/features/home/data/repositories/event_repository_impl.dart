import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/error/failure.dart';
import 'package:esl/core/networks/network_info.dart';
import 'package:esl/features/home/data/datasources/event_remote_datasource.dart';
import 'package:esl/features/home/domain/entities/event.dart';
import 'package:esl/features/home/domain/repositories/event_repository.dart';
import 'package:fpdart/fpdart.dart';

class EventRepositoryImpl extends EventRepository {
  final EventRemoteDataSource eventRemoteDataSource;
  final NetworkInfo networkInfo;

  EventRepositoryImpl({
    required this.eventRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Event>>> getEvents() async {
    if (await networkInfo.isConnected) {
      try {
        final events = await eventRemoteDataSource.getEvents();
        return Right(events.map((e) => e.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, errorDetails: e.errorDetails),
        );
      }
    } else {
      // try {
      //   final events = await eventRemoteDataSource.getEvents();
      //   return Right(events.map((e) => e.toEntity()).toList());
      // } on CacheException catch (e) {
      return const Left(NetworkFailure(message: 'No internet connection'));
      // }
    }
  }

  @override
  Future<Either<Failure, Event>> getEvent(String id) {
    // TODO: implement getEvent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Event>>> getEventsByDate(DateTime date) async {
    if (await networkInfo.isConnected) {
      try {
        final events = await eventRemoteDataSource.getEventsByDate(date);
        return Right(events.map((e) => e.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, errorDetails: e.errorDetails),
        );
      }
    } else {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getEventsByStatus(String status) {
    // TODO: implement getEventsByStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Event>>> getEventsByType(String type) {
    // TODO: implement getEventsByType
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Event>>> getEventsByVisibility(
    String visibility,
  ) {
    // TODO: implement getEventsByVisibility
    throw UnimplementedError();
  }
}
