import 'dart:convert';

import 'package:esl/features/my_course/domain/entities/required_document.dart';

class RequiredDocumentModel extends RequiredDocument {
  const RequiredDocumentModel({
    super.id,
    super.name,
    super.description,
    super.document,
  });

  factory RequiredDocumentModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? description;
    if (json['description'] != null) {
      if (json['description'] is String) {
        try {
          description =
              jsonDecode(json['description'] as String) as Map<String, dynamic>;
        } catch (e) {
          description = {'text': json['description'] as String};
        }
      } else if (json['description'] is Map<String, dynamic>) {
        description = json['description'] as Map<String, dynamic>;
      }
    }
    return RequiredDocumentModel(
      id: json['id'] as String?,
      name: json['title'] as String?,
      description: description,
      document: json['document'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'document': document,
    };
  }

  // Special method for enrolment required documents
  Map<String, dynamic> toEnrolmentJson() {
    return {'requiredDocumentId': id, 'document': document};
  }

  factory RequiredDocumentModel.fromEntity(RequiredDocument entity) {
    return RequiredDocumentModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      document: entity.document,
    );
  }

  RequiredDocument toEntity() {
    return RequiredDocument(
      id: id,
      name: name,
      description: description,
      document: document,
    );
  }
}
