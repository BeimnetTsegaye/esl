part of 'event_bloc.dart';

class EventState {
  const EventState();
}

class InitialEventState extends EventState {}

class LoadingEventState extends EventState {
  final Event fakeEvent = Event(
    id: '0',
    excerpt: 'Please wait while we load the events.',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 1)),
    title: '',
    featuredImage: 'https://via.placeholder.com/150',
    content: 'Please wait while we load the events.',
    isPromotedToHero: false,
    category: const EventCategory(
      id: '1',
      category: 'Fake Event Category',
      description: 'Fake Event Description',
    ),
  );

  LoadingEventState();
}

class LoadedEventState extends EventState {
  final List<Event> events;

  LoadedEventState(this.events);
}

class ErrorEventState extends EventState {
  final String message;

  ErrorEventState(this.message);
}
