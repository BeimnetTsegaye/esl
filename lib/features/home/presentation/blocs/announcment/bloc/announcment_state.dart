part of 'announcment_bloc.dart';

class AnnouncmentState {
  const AnnouncmentState();
}

class AnnouncmentInitial extends AnnouncmentState {}

class AnnouncmentLoading extends AnnouncmentState {
  final List<Announcment> fakeAnnouncments = const [
    Announcment(title: 'Announcment 1', description: 'Description 1'),
    Announcment(title: 'Announcment 2', description: 'Description 2'),
    Announcment(title: 'Announcment 3', description: 'Description 3'),
  ];

}

class AnnouncmentLoaded extends AnnouncmentState {
  final List<Announcment> announcments;

  AnnouncmentLoaded(this.announcments);
}

class AnnouncmentEmpty extends AnnouncmentState {}

class AnnouncmentError extends AnnouncmentState {
  final String message;

  AnnouncmentError({required this.message});
}
