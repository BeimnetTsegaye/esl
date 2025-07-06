part of 'announcment_bloc.dart';

abstract class AnnouncmentEvent {}

class GetAnnouncmentsEvent extends AnnouncmentEvent {}

class RefreshAnnouncmentsEvent extends AnnouncmentEvent {}

class RemoveAnnouncmentEvent extends AnnouncmentEvent {
  final int index;

  RemoveAnnouncmentEvent(this.index);
}
