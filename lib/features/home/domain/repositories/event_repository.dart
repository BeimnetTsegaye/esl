import 'package:esl/core/error/failure.dart';
import 'package:esl/features/home/domain/entities/event.dart';
import 'package:fpdart/fpdart.dart';

abstract class EventRepository {
  Future<Either<Failure, List<Event>>> getEvents();
  Future<Either<Failure, Event>> getEvent(String id);
  Future<Either<Failure, List<Event>>> getEventsByDate(DateTime date);
  Future<Either<Failure, List<Event>>> getEventsByType(String type);
  Future<Either<Failure, List<Event>>> getEventsByStatus(String status);
  Future<Either<Failure, List<Event>>> getEventsByVisibility(String visibility);
}
