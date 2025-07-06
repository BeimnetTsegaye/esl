import 'package:equatable/equatable.dart';

class LanguageProficiency extends Equatable {
  final String? id;
  final String? languageName;
  final List<ProficiencyLevel>? proficiencyLevels;

  const LanguageProficiency({
    this.id,
    this.languageName,
    this.proficiencyLevels,
  });

  @override
  List<Object?> get props => [id, languageName, proficiencyLevels];
}

class ProficiencyLevel extends Equatable {
  final String? name;
  final String? value;

  const ProficiencyLevel({this.name, this.value});

  @override
  List<Object?> get props => [name, value];
}
