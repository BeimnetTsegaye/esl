import 'package:esl/features/auth/data/models/user_model.dart';
import 'package:esl/features/program/domain/entities/director.dart';

class DirectorModel extends Director {
  const DirectorModel({super.id, super.user, super.title, super.description});

  factory DirectorModel.fromJson(Map<String, dynamic> json) {
    // Handle description field - it can be a JSON object or string
    String? description;
    if (json['description'] != null) {
      if (json['description'] is String) {
        description = json['description'] as String;
      } else if (json['description'] is Map<String, dynamic>) {
        description = json['description'].toString();
      }
    }

    return DirectorModel(
      id: json['id'] as String?,
      user: json['user'] != null 
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>).toEntity()
          : null,
      title: json['title'] as String?,
      description: description,
    );
  }

  Director toEntity() {
    return Director(id: id, user: user, title: title, description: description);
  }
}
