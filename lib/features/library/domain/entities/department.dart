import 'dart:convert';

import 'package:esl/features/library/data/models/library_model.dart';
import 'package:esl/features/library/domain/entities/library.dart';

class DepartmentDescription {
  final String mission;
  final String vision;
  final DepartmentHead head;

  DepartmentDescription({
    required this.mission,
    required this.vision,
    required this.head,
  });

  factory DepartmentDescription.fromJson(Map<String, dynamic> json) {
    return DepartmentDescription(
      mission: json['mission'] as String,
      vision: json['vision'] as String,
      head: DepartmentHead.fromJson(json['head'] as Map<String, dynamic>),
    );
  }
}

class DepartmentHead {
  final String name;
  final String email;

  DepartmentHead({
    required this.name,
    required this.email,
  });

  factory DepartmentHead.fromJson(Map<String, dynamic> json) {
    return DepartmentHead(
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}

class Department {
  final String id;
  final String? departmentId;
  final String name;
  final String facultyId;
  final DepartmentDescription? description;
  final String imageUrl;
  final List<Library> resources;

  Department({
    required this.id,
    required this.departmentId,
    required this.name,
    required this.facultyId,
    this.description,
    required this.imageUrl,
    this.resources = const [],
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'] as String,
      departmentId: json['department_id'] as String?,
      name: json['name'] as String,
      facultyId: json['faculty_id'] as String,
      description: json['description'] != null
          ? DepartmentDescription.fromJson(
              Map<String, dynamic>.from(
                jsonDecode(json['description'] as String) as Map,
              ),
            )
          : null,
      imageUrl: json['image_url'] as String,
      resources:
          (json['Library'] as List<dynamic>?)
              ?.map(
                (resource) => LibraryModel.fromJson(
                  resource as Map<String, dynamic>,
                ).toEntity(),
              )
              .toList() ??
          const [],
    );
  }
}
