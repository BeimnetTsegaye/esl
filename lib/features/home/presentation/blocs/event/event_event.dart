part of 'event_bloc.dart';

abstract class EventEvent {}

class GetEventsByDateEvent extends EventEvent {
  final DateTime date;

  GetEventsByDateEvent(this.date);
}

class RefreshEvents extends EventEvent {
  final DateTime date;

  RefreshEvents(this.date);
}
