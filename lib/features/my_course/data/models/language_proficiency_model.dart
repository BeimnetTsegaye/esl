import 'package:esl/features/my_course/domain/entities/language_proficiency.dart';

class LanguageProficiencyModel extends LanguageProficiency {
  const LanguageProficiencyModel({
    super.id,
    super.languageName,
    super.proficiencyLevels,
  });

  factory LanguageProficiencyModel.fromJson(Map<String, dynamic> json) {
    return LanguageProficiencyModel(
      id: json['id'] as String?,
      languageName: json['languageName'] as String?,
      proficiencyLevels: (json['proficiencyLevels'] as List<dynamic>?)
          ?.map((level) => ProficiencyLevelModel.fromJson(level as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'languageName': languageName,
      'proficiencyLevels': proficiencyLevels
          ?.map((level) => ProficiencyLevelModel.fromEntity(level).toJson())
          .toList(),
    };
  }

  factory LanguageProficiencyModel.fromEntity(LanguageProficiency entity) {
    return LanguageProficiencyModel(
      id: entity.id,
      languageName: entity.languageName,
      proficiencyLevels: entity.proficiencyLevels
          ?.map((level) => ProficiencyLevelModel.fromEntity(level))
          .toList(),
    );
  }

  LanguageProficiency toEntity() {
    return LanguageProficiency(
      id: id,
      languageName: languageName,
      proficiencyLevels: proficiencyLevels,
    );
  }
}

class ProficiencyLevelModel extends ProficiencyLevel {
  const ProficiencyLevelModel({super.name, super.value});

  factory ProficiencyLevelModel.fromJson(Map<String, dynamic> json) {
    return ProficiencyLevelModel(
      name: json['name'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': _parseProficiencyName(name),
      'value': _parseProficiencyValue(value),
    };
  }

  factory ProficiencyLevelModel.fromEntity(ProficiencyLevel entity) {
    return ProficiencyLevelModel(
      name: entity.name,
      value: entity.value,
    );
  }

  ProficiencyLevel toEntity() {
    return ProficiencyLevel(name: name, value: value);
  }

  String? _parseProficiencyName(String? name) {
    if (name == null) return null;
    
    switch (name.toLowerCase()) {
      case 'reading':
        return 'Reading';
      case 'writing':
        return 'Writing';
      case 'speaking':
        return 'Speaking';
      case 'listening':
        return 'Listening';
      default:
        return 'Reading'; // Default fallback
    }
  }

  String? _parseProficiencyValue(String? value) {
    if (value == null) return null;
    
    switch (value.toLowerCase()) {
      case 'basic':
        return 'Basic';
      case 'intermediate':
        return 'Intermediate';
      case 'advanced':
        return 'Advanced';
      case 'native':
        return 'Native';
      default:
        return 'Basic'; // Default fallback
    }
  }
} 