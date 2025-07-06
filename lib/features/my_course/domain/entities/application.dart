import 'package:equatable/equatable.dart';
import 'package:esl/features/my_course/domain/entities/educational_background.dart';
import 'package:esl/features/my_course/domain/entities/employment_history.dart';
import 'package:esl/features/my_course/domain/entities/enrollment_reference.dart';
import 'package:esl/features/my_course/domain/entities/language_proficiency.dart';
import 'package:esl/features/my_course/domain/entities/required_document.dart';

class Application extends Equatable {
  final String? id;
  final String? userId;
  final String? programId;
  final String? program_id;
  final String? dob;
  final String? birthCountry;
  final String? birthCity;
  final String? gender;
  final String? nationality;
  final String? idType;
  final String? idNumber;
  final String? idDocument;
  final String? address;
  final String? city;
  final String? homeAddress;
  final String? wereda;
  final String? religion;
  final String? seamanBook;
  final String? nearestPoliceStation;
  final String? healthIssue;
  final String? convictedCrimeDescription;
  final String? crimeRecordDocument;
  final String? postalAddress;
  final String? maritalStatus;
  final int? numberOfChildren;
  final String? mobileNumber;
  final String? alternateEmailAddress;
  final String? emergencyPersonName;
  final String? relationshipWithEmergencyPerson;
  final String? emergencyPersonAddress;
  final String? emergencyPersonPhoneNumber;
  final String? emergencyPersonAlternatePhoneNumber;
  final bool? convicted;
  final String? goalsMaritimeAcademy;
  final String? careerAspirations;
  final bool? physicallyImpaired;
  final String? status;
  final String? paymentStatus;
  final String? passportSizePhoto;
  final List<EducationalBackground>? educationalBackgrounds;
  final List<LanguageProficiency>? languageProficiencies;
  final List<EmploymentHistory>? employmentHistories;
  final List<EnrollmentReference>? references;
  final List<RequiredDocument>? requiredDocuments;

  const Application({
    this.id,
    this.userId,
    this.programId,
    this.program_id,
    this.dob,
    this.birthCountry,
    this.birthCity,
    this.gender,
    this.nationality,
    this.idType,
    this.idNumber,
    this.idDocument,
    this.address,
    this.city,
    this.homeAddress,
    this.wereda,
    this.religion,
    this.seamanBook,
    this.nearestPoliceStation,
    this.healthIssue,
    this.convictedCrimeDescription,
    this.crimeRecordDocument,
    this.postalAddress,
    this.maritalStatus,
    this.numberOfChildren,
    this.mobileNumber,
    this.alternateEmailAddress,
    this.emergencyPersonName,
    this.relationshipWithEmergencyPerson,
    this.emergencyPersonAddress,
    this.emergencyPersonPhoneNumber,
    this.emergencyPersonAlternatePhoneNumber,
    this.convicted,
    this.goalsMaritimeAcademy,
    this.careerAspirations,
    this.physicallyImpaired,
    this.status,
    this.paymentStatus,
    this.passportSizePhoto,
    this.educationalBackgrounds,
    this.languageProficiencies,
    this.employmentHistories,
    this.references,
    this.requiredDocuments,
  });

  @override
  List<Object?> get props => [
    id, userId, programId, program_id, dob, birthCountry, birthCity, gender,
    nationality, idType, idNumber, idDocument, address, city, homeAddress,
    wereda, religion, seamanBook, nearestPoliceStation, healthIssue,
    convictedCrimeDescription, crimeRecordDocument, postalAddress, maritalStatus,
    numberOfChildren, mobileNumber, alternateEmailAddress, emergencyPersonName,
    relationshipWithEmergencyPerson, emergencyPersonAddress, emergencyPersonPhoneNumber,
    emergencyPersonAlternatePhoneNumber, convicted, goalsMaritimeAcademy,
    careerAspirations, physicallyImpaired, status, paymentStatus, passportSizePhoto,
    educationalBackgrounds, languageProficiencies, employmentHistories, references, requiredDocuments,
  ];
}
