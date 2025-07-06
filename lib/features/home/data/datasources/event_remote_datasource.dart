import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/features/home/data/datasources/home_endpoints.dart';
import 'package:esl/features/home/data/models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<List<EventModel>> getEvents();
  Future<EventModel> getEvent(String id);
  Future<List<EventModel>> getEventsByDate(DateTime date);
  Future<List<EventModel>> getEventsByStatus(String status);
  Future<List<EventModel>> getEventsByType(String type);
  Future<List<EventModel>> getEventsByVisibility(String visibility);
}

class EventRemoteDataSourceImpl extends EventRemoteDataSource {
  final DioClient dioClient;
  EventRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<EventModel>> getEvents() async {
    try {
      final response = await dioClient.get<List<EventModel>>(
        HomeEndpoints.getEvents,
        fromJsonT: (json) {
          if (json is! List) {
            throw ServerException('Expected a list of events');
          }
          return json
              .map(
                (eventJson) =>
                    EventModel.fromJson(eventJson as Map<String, dynamic>),
              )
              .toList();
        },
      );
      if (!response.success) {
        throw ServerException(response.message, response.error);
      }
      return response.data!;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<EventModel> getEvent(String id) async {
    try {
      final response = await dioClient.get<EventModel>(
        '/events/$id',
        fromJsonT: (json) => EventModel.fromJson(json as Map<String, dynamic>),
      );
      if (!response.success) {
        throw ServerException(response.message, response.error);
      }
      return response.data!;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<EventModel>> getEventsByDate(DateTime date) async {
    try {
      final response = await dioClient.get<List<EventModel>>(
        HomeEndpoints.getEvents,
        queryParameters: {'startDate': date.toIso8601String()},
        fromJsonT: (json) {
          if (json is! List) {
            throw ServerException('Expected a list of events');
          }
          return json
              .map(
                (eventJson) =>
                    EventModel.fromJson(eventJson as Map<String, dynamic>),
              )
              .toList();
        },
      );
      if (!response.success) {
        throw ServerException(response.message, response.error);
      }
      return response.data!;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<EventModel>> getEventsByStatus(String status) async {
    try {
      final response = await dioClient.get<List<EventModel>>(
        '/events/by-status',
        queryParameters: {'status': status.split('.').last},
        fromJsonT: (json) {
          if (json is! List) {
            throw ServerException('Expected a list of events');
          }
          return json
              .map(
                (eventJson) =>
                    EventModel.fromJson(eventJson as Map<String, dynamic>),
              )
              .toList();
        },
      );
      if (!response.success) {
        throw ServerException(response.message, response.error);
      }
      return response.data!;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<EventModel>> getEventsByType(String type) async {
    try {
      final response = await dioClient.get<List<EventModel>>(
        '/events/by-type',
        queryParameters: {'type': type.split('.').last},
        fromJsonT: (json) {
          if (json is! List) {
            throw ServerException('Expected a list of events');
          }
          return json
              .map(
                (eventJson) =>
                    EventModel.fromJson(eventJson as Map<String, dynamic>),
              )
              .toList();
        },
      );
      if (!response.success) {
        throw ServerException(response.message, response.error);
      }
      return response.data!;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<EventModel>> getEventsByVisibility(String visibility) async {
    try {
      final response = await dioClient.get<List<EventModel>>(
        '/events/by-visibility',
        queryParameters: {'visibility': visibility.split('.').last},
        fromJsonT: (json) {
          if (json is! List) {
            throw ServerException('Expected a list of events');
          }
          return json
              .map(
                (eventJson) =>
                    EventModel.fromJson(eventJson as Map<String, dynamic>),
              )
              .toList();
        },
      );
      if (!response.success) {
        throw ServerException(response.message, response.error);
      }
      return response.data!;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
