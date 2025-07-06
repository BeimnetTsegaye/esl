import 'package:equatable/equatable.dart';
import 'package:esl/features/my_course/domain/entities/course.dart';
import 'package:esl/features/my_course/domain/entities/required_document.dart';
import 'package:esl/features/program/domain/entities/criteria.dart';
import 'package:esl/features/program/domain/entities/director.dart';

class Program extends Equatable {
  final String? id;
  final String? name;
  final String? programCode;
  final String? description;
  final Director? director;
  final String? programImage;
  final String? directorId;
  final String? price;
  final int? passPoint;
  final List<Course>? courses;
  final List<EligibilityCriteria>? eligibilityCriteria;
  final List<RequiredDocument>? requiredDocuments;

  const Program({
    this.id,
    this.name,
    this.description,
    this.director,
    this.programImage,
    this.directorId,
    this.courses,
    this.eligibilityCriteria,
    this.passPoint,
    this.price,
    this.programCode,
    this.requiredDocuments,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    director,
    programImage,
    directorId,
    courses,
    eligibilityCriteria,
    passPoint,
    price,
    programCode,
    requiredDocuments,
  ];
}
