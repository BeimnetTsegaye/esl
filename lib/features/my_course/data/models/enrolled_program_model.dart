import 'package:esl/features/program/data/models/program_model.dart';
import 'package:esl/features/program/domain/entities/program.dart';

enum ApplicationStatus {
  PENDING, // Application submitted, awaiting initial academy review.
  ADMITTED, // Application accepted by the academy.
  REJECTED, // Application rejected at any stage (by academy or finance).
  AWAITING_PAYMENT, // Admitted, and payment information has been sent to the applicant, waiting for their payment.
  PAYMENT_RECEIVED_PENDING_APPROVAL, // Applicant has paid, and finance department needs to verify/approve the payment.
  ENROLLED, // Payment approved, student officially enrolled.
  COMPLETED, // Student has completed the program, final result inserted.
}

class EnrolledProgramModel {
  final ApplicationStatus applicationState;
  final Program program;

  const EnrolledProgramModel({
    required this.applicationState,
    required this.program,
  });

  factory EnrolledProgramModel.fromJson(Map<String, dynamic> json) {
    return EnrolledProgramModel(
      applicationState: _parseApplicationStatus(json['applicationState'] as String? ?? ''),
      program: ProgramModel.fromJson(json['program'] as Map<String, dynamic>).toEntity(),
    );
  }

  static ApplicationStatus _parseApplicationStatus(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return ApplicationStatus.PENDING;
      case 'ADMITTED':
        return ApplicationStatus.ADMITTED;
      case 'REJECTED':
        return ApplicationStatus.REJECTED;
      case 'AWAITING_PAYMENT':
        return ApplicationStatus.AWAITING_PAYMENT;
      case 'PAYMENT_RECEIVED_PENDING_APPROVAL':
        return ApplicationStatus.PAYMENT_RECEIVED_PENDING_APPROVAL;
      case 'ENROLLED':
        return ApplicationStatus.ENROLLED;
      case 'COMPLETED':
        return ApplicationStatus.COMPLETED;
      default:
        return ApplicationStatus.PENDING; // Default fallback
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'applicationState': applicationState.name,
      'program': program,
    };
  }

  EnrolledProgramModel copyWith({
    ApplicationStatus? applicationState,
    Program? program,
  }) {
    return EnrolledProgramModel(
      applicationState: applicationState ?? this.applicationState,
      program: program ?? this.program,
    );
  }
} 