import 'package:esl/features/home/domain/entities/announcment.dart';

class AnnouncmentModel extends Announcment {
  const AnnouncmentModel({required super.title, required super.description});

  factory AnnouncmentModel.fromJson(Map<String, dynamic> json) {
    return AnnouncmentModel(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  Announcment toEntity() {
    return Announcment(title: title, description: description);
  }
}
