import 'dart:convert';

import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/widgets/bullet_text.dart';
import 'package:esl/features/my_course/presentation/blocs/my_course/my_course_bloc.dart';
import 'package:esl/features/program/domain/entities/program.dart';
import 'package:esl/features/program/presentation/blocs/program/program_bloc.dart';
import 'package:esl/features/program/presentation/widgets/course_card.dart';
import 'package:esl/features/program/presentation/widgets/director_card.dart';
import 'package:esl/features/program/presentation/widgets/program_detail_card.dart';
import 'package:esl/features/program/presentation/widgets/req_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProgramDetailPage extends StatefulWidget {
  const ProgramDetailPage({super.key});

  @override
  State<ProgramDetailPage> createState() => _ProgramDetailPageState();
}

class _ProgramDetailPageState extends State<ProgramDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<MyCourseBloc>().add(const GetEnrolledProgramEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramBloc, ProgramState>(
      builder: (context, programState) {
        Program? selectedProgram;
        if (programState is ProgramLoaded) {
          selectedProgram = programState.selectedProgram;
        } else if (programState is ProgramError) {
          selectedProgram = programState.selectedProgram;
        } else if (programState is ProgramEmpty) {
          selectedProgram = programState.selectedProgram;
        }

        if (selectedProgram == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Program Details')),
            body: const Center(child: Text('No program selected')),
          );
        }

        return BlocBuilder<MyCourseBloc, MyCourseState>(
          builder: (context, myCourseState) {
            bool hasApplied = false;
            if (myCourseState is EnrolledProgramLoaded) {
              hasApplied = myCourseState.myPrograms.any(
                (enrolledProgram) =>
                    enrolledProgram.program.id == selectedProgram?.id,
              );
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text('Program Details'),
                actions: [
                  if (!hasApplied)
                    TextButton(
                      onPressed: () {
                        context.push(
                          AppConstants.registrationRoute,
                          extra: selectedProgram,
                        );
                      },
                      child: const Text('Apply Now'),
                    ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ProgramDetailCard(
                      title: selectedProgram?.name ?? 'Program Name',
                      price: selectedProgram?.price ?? 'Price not available',
                      passPoint: selectedProgram?.passPoint ?? null,

                      description: parseDescription(
                        selectedProgram?.description,
                      ),
                    ),
                    const SizedBox(height: 20),

                    if (selectedProgram?.directorId != null) ...[
                      Text(
                        'Director',
                        style: boldTextStyle.copyWith(fontSize: 23),
                      ),
                      const SizedBox(height: 20),

                      DirectorCard(
                        name:
                            selectedProgram?.director?.user?.firstName ??
                            'Director',
                        title: selectedProgram?.director?.title ?? 'Director',
                        description:
                            selectedProgram?.director?.description ??
                            'No description available',
                      ),
                      const SizedBox(height: 20),
                    ],

                    // Courses section
                    if (selectedProgram?.courses?.isNotEmpty ?? false) ...[
                      Text(
                        'Courses',
                        style: boldTextStyle.copyWith(fontSize: 23),
                      ),
                      const SizedBox(height: 20),
                      ...(selectedProgram?.courses ?? [])
                          .map(
                            (course) => Column(
                              children: [
                                CourseCard(
                                  title: course.title ?? 'Course Name',
                                  duration: course.duration ?? '',
                                  description:
                                      parseDescription(course.description) ??
                                      {},
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          )
                          .toList(),
                      const SizedBox(height: 20),
                    ],

                    // Eligibility Criteria section
                    if (selectedProgram?.eligibilityCriteria?.isNotEmpty ??
                        false) ...[
                      Text(
                        'Eligibility Criteria',
                        style: boldTextStyle.copyWith(fontSize: 23),
                      ),
                      const SizedBox(height: 20),
                      ...(selectedProgram?.eligibilityCriteria ?? [])
                          .map(
                            (criteria) => Column(
                              children: [
                                BulletText(
                                  text:
                                      criteria.title ??
                                      'No criteria description',
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          )
                          .toList(),
                      const SizedBox(height: 20),
                    ],

                    // Required Documents section
                    if (selectedProgram?.requiredDocuments?.isNotEmpty ??
                        false) ...[
                      Text(
                        'Required Documents',
                        style: boldTextStyle.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      ...(selectedProgram?.requiredDocuments ?? [])
                          .map(
                            (doc) => Column(
                              children: [
                                ReqCard(
                                  title: doc.name ?? 'Document Name',
                                  description: doc.description ?? {},
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          )
                          .toList(),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Map<String, dynamic>? parseDescription(dynamic desc) {
    if (desc == null) return null;
    if (desc is Map<String, dynamic>) return desc;
    if (desc is String && desc.isNotEmpty) {
      try {
        final decoded = jsonDecode(desc);
        if (decoded is Map<String, dynamic>) return decoded;
      } catch (_) {}
    }
    return null;
  }
}
