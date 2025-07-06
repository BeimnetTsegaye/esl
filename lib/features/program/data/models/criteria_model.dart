import 'package:esl/features/program/domain/entities/criteria.dart';

class EligibilityCriteriaModel extends EligibilityCriteria {
  const EligibilityCriteriaModel({super.id, super.title, super.description});

  factory EligibilityCriteriaModel.fromJson(Map<String, dynamic> json) {
    return EligibilityCriteriaModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }

  EligibilityCriteria toEntity() {
    return EligibilityCriteria(
      id: id,
      title: title,
      description: description,
    );
  }
}
