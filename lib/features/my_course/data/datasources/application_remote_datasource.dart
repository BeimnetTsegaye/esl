import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:esl/core/error/exceptions.dart';
import 'package:esl/core/networks/dio_client.dart';
import 'package:esl/features/my_course/data/datasources/my_course_endpoints.dart';
import 'package:esl/features/my_course/data/models/application_model.dart';
import 'package:esl/features/my_course/data/models/educational_background_model.dart';
import 'package:esl/features/my_course/data/models/employment_history_model.dart';
import 'package:esl/features/my_course/data/models/enrollment_reference_model.dart';
import 'package:esl/features/my_course/data/models/language_proficiency_model.dart';
import 'package:esl/features/my_course/data/models/required_document_model.dart';

abstract class ApplicationRemoteDataSource {
  Future<ApplicationModel> apply({required ApplicationModel application});
}

class ApplicationRemoteDataSourceImpl implements ApplicationRemoteDataSource {
  final DioClient dioClient;
  ApplicationRemoteDataSourceImpl({required this.dioClient});
  @override
  Future<ApplicationModel> apply({
    required ApplicationModel application,
  }) async {
    final applicationJson = application.toJson();

    // Remove null values and complex objects
    applicationJson.removeWhere((key, value) => value == null);
    applicationJson.remove('passportSizePhoto');
    applicationJson.remove('crimeRecordDocument');
    applicationJson.remove('idDocument');
    applicationJson.remove('requiredDocuments');
    applicationJson.remove('educationalBackgrounds');
    applicationJson.remove('languageProficiencies');
    applicationJson.remove('employmentHistories');
    applicationJson.remove('references');

    final formData = FormData.fromMap({
      ...applicationJson,
      'educationalBackgrounds': jsonEncode(
        application.educationalBackgrounds
            ?.map((e) => EducationalBackgroundModel(
                  instituteName: e.instituteName,
                  qualification: e.qualification,
                  fieldOfStudy: e.fieldOfStudy,
                  statedDate: e.statedDate,
                  endDate: e.endDate,
                  certificate: e.certificate,
                ).toJson())
            .toList(),
      ),
      'languageProficiencies': jsonEncode(
        application.languageProficiencies
            ?.map((e) => LanguageProficiencyModel(
                  languageName: e.languageName,
                  proficiencyLevels: e.proficiencyLevels,
                ).toJson())
            .toList(),
      ),
      'employmentHistories': jsonEncode(
        application.employmentHistories
            ?.map((e) => EmploymentHistoryModel(
                  jobTitle: e.jobTitle,
                  companyName: e.companyName,
                  employmentType: e.employmentType,
                  statedDate: e.statedDate,
                  endDate: e.endDate,
                  isCurrentJob: e.isCurrentJob,
                ).toJson())
            .toList(),
      ),
      'references': jsonEncode(
        application.references
            ?.map((e) => EnrollmentReferenceModel(
                  title: e.title,
                  institution: e.institution,
                  contactNumber: e.contactNumber,
                ).toJson())
            .toList(),
      ),
    });

    // Handle educational background certificates
    if (application.educationalBackgrounds != null) {
      for (final bg in application.educationalBackgrounds!) {
        if (bg.certificate != null && bg.certificate!.isNotEmpty) {
          formData.files.add(MapEntry(
            'certificates',
            await MultipartFile.fromFile(bg.certificate!),
          ));
        }
      }
    }

    // Handle required documents with proper structure
    if (application.requiredDocuments != null) {
      final requiredDocsList = application.requiredDocuments?.map((d) {
            return RequiredDocumentModel.fromEntity(d).toEnrolmentJson();
          }).toList() ??
          [];
      formData.fields.add(MapEntry('requiredDocuments', jsonEncode(requiredDocsList)));

      for (final doc in application.requiredDocuments!) {
        if (doc.document != null && doc.document!.isNotEmpty) {
          formData.files.add(MapEntry(
            'documents',
            await MultipartFile.fromFile(doc.document!),
          ));
        }
      }
    }

    // Handle passport size photo
    if (application.passportSizePhoto != null && application.passportSizePhoto!.isNotEmpty) {
      formData.files.add(MapEntry(
        'passportSizePhoto',
        await MultipartFile.fromFile(application.passportSizePhoto!),
      ));
    }

    // Handle crime record document
    if (application.crimeRecordDocument != null && application.crimeRecordDocument!.isNotEmpty) {
      formData.files.add(MapEntry(
        'crimeRecordDocument',
        await MultipartFile.fromFile(application.crimeRecordDocument!),
      ));
    }

    // Handle ID document
    if (application.idDocument != null && application.idDocument!.isNotEmpty) {
      formData.files.add(MapEntry(
        'idDocument',
        await MultipartFile.fromFile(application.idDocument!),
      ));
    }

    final response = await dioClient.postMultipart(
      MyCourseEndpoints.apply,
      data: formData,
      fromJsonT: (json) => ApplicationModel.fromJson(json as Map<String, dynamic>),
    );
    if (!response.success) {
      throw ServerException(response.message, response.error);
    }
    return response.data!;
  }
}
