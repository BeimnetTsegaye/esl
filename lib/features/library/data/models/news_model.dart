// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:esl/features/auth/data/models/user_model.dart' show UserModel;

class Comment {
  final String id;
  final String status;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel user;
  Comment({
    required this.id,
    required this.status,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
      status: json['status'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
