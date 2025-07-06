import 'package:esl/core/networks/api_endpoints.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:esl/features/my_course/data/models/enrolled_program_model.dart';
import 'package:esl/features/program/domain/entities/program.dart';
import 'package:esl/features/program/presentation/blocs/program/program_bloc.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum ProgramStatus {
  pending('Pending'),
  admitted('Admitted'),
  rejected('Rejected'),
  awaitingPayment('Awaiting Payment'),
  paymentReceivedPendingApproval('Payment Received - Pending Approval'),
  enrolled('Grade and Resources'),
  completed('Completed'),
  notEnrolled('Apply Now');

  final String status;
  const ProgramStatus(this.status);

  static ProgramStatus fromApplicationStatus(
    ApplicationStatus applicationStatus,
  ) {
    switch (applicationStatus) {
      case ApplicationStatus.PENDING:
        return ProgramStatus.pending;
      case ApplicationStatus.ADMITTED:
        return ProgramStatus.admitted;
      case ApplicationStatus.REJECTED:
        return ProgramStatus.rejected;
      case ApplicationStatus.AWAITING_PAYMENT:
        return ProgramStatus.awaitingPayment;
      case ApplicationStatus.PAYMENT_RECEIVED_PENDING_APPROVAL:
        return ProgramStatus.paymentReceivedPendingApproval;
      case ApplicationStatus.ENROLLED:
        return ProgramStatus.enrolled;
      case ApplicationStatus.COMPLETED:
        return ProgramStatus.completed;
    }
  }
}

class ProgramCard extends StatelessWidget {
  const ProgramCard({
    super.key,
    required this.programId,
    required this.programName,
    required this.batch,
    this.programStatus = ProgramStatus.notEnrolled,
    this.program,
    required this.programImage,
  });

  final String programName;
  final ProgramStatus programStatus;
  final String programId;
  final String batch;
  final Program? program;
  final String programImage;

  void _handlePrimaryAction(BuildContext context) {
    final authState = context.read<AuthBloc>().state;

    switch (programStatus) {
      case ProgramStatus.enrolled:
        context.push(AppConstants.gradeRoute);
        break;
      case ProgramStatus.rejected:
        context.push(AppConstants.rejectedRoute);
        break;
      case ProgramStatus.pending:
      case ProgramStatus.paymentReceivedPendingApproval:
        context.push(AppConstants.pendingRoute);
        break;
      case ProgramStatus.awaitingPayment:
      case ProgramStatus.admitted:
        context.push(AppConstants.tuitionRoute);
        break;
      case ProgramStatus.completed:
        context.push(AppConstants.gradeRoute);
        break;
      case ProgramStatus.notEnrolled:
        if (authState is Authenticated && program != null) {
          context.push(AppConstants.registrationRoute, extra: program);
        } else if (authState is! Authenticated) {
          context.push(AppConstants.loginRoute, extra: true);
        }
        break;
    }
  }

  void _handleViewDetails(BuildContext context) {
    if (program != null) {
      context.read<ProgramBloc>().add(SelectProgram(program!));
      context.push(AppConstants.programDetailRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _handleViewDetails(context),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageWithBadge(context),
              _buildContent(context, theme),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the top image and overlays the status badge.
  Widget _buildImageWithBadge(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 150,
          child: Image.network(
            programImage.startsWith('http')
                ? programImage
                : '${baseUrl.replaceAll('/api', '')}${programImage.startsWith('/') ? '' : '/'}$programImage',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.shade200,
              child: Icon(
                FluentIcons.image_off_24_regular,
                color: Colors.grey.shade400,
                size: 48,
              ),
            ),
          ),
        ),
        // Positioned Status Badge
        Positioned(
          top: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              // color: programStatus.color,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon(programStatus.icon,
                //  color: Colors.white, size: 14),
                const SizedBox(width: 4),
                Text(
                  programStatus.status.split(
                    ' ',
                  )[0], // Show first word e.g., "Awaiting"
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the bottom section with text and the action button.
  Widget _buildContent(BuildContext context, ThemeData theme) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Program Title and Batch
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  programName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Batch: $batch',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            // Primary Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _handlePrimaryAction(context),
                // icon: Icon(programStatus.icon, size: 18),
                label: Text(programStatus.status),
                style: ElevatedButton.styleFrom(
                  // backgroundColor: programStatus.color,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
