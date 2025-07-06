import 'dart:ui';

import 'package:esl/core/networks/api_endpoints.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/features/program/domain/entities/program.dart';
import 'package:esl/features/program/presentation/blocs/program/program_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({super.key});

  @override
  State<ProgramsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<ProgramsPage> {
  final List<Program> program = [];
  final ScrollController _scrollController = ScrollController();
  final boldTextStyle = const TextStyle(fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    // Load programs when the page is first opened
    context.read<ProgramBloc>().add(const LoadPrograms());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildLoadingState() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.8,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            margin: const EdgeInsets.only(left: 6, top: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                const SizedBox(height: 8),
                Container(height: 16, width: 120, color: Colors.grey[300]),
                const SizedBox(height: 4),
                Container(height: 12, width: 80, color: Colors.grey[200]),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Text(message, style: const TextStyle(color: Colors.red)),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0),
        child: Text('No programs available at the moment.'),
      ),
    );
  }

  Widget _buildProgramsGrid(
    List<Program> programs, {
    bool isLoading = false,
    required void Function(Program program) onViewDetails,
    required void Function(Program program) onApplyNow,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.8,
      ),
      itemCount: programs.length,
      itemBuilder: (context, index) {
        final program = programs[index];
        final imageUrl =
            program.programImage != null && program.programImage!.isNotEmpty
            ? (program.programImage!.startsWith('http')
                  ? program.programImage!
                  : '${baseUrl.replaceAll('/api', '')}/${program.programImage!.startsWith('/') ? program.programImage!.substring(1) : program.programImage!}')
            : null;

        return Card(
          // clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(12.0),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image with Blur
              if (imageUrl != null && !isLoading)
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.broken_image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                )
              else
                Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.school, size: 40, color: Colors.grey),
                ),

              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isLoading)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 14,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            program.name ?? 'No Name',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 3.0,
                                  color: Colors.black45,
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            program.programCode ?? 'No Code',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2.0,
                                  color: Colors.black45,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 12,
                            left: 0,
                            right: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildActionButton(
                                  'View Details',
                                  context,
                                  program,
                                ),
                                const SizedBox(height: 10),
                                _buildActionButtonapply(
                                  'Apply Now',
                                  context,
                                  program,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton(
    String text,
    BuildContext context,
    Program program,
  ) {
    void _handleViewDetails() {
      context.read<ProgramBloc>().add(SelectProgram(program));
      context.push(AppConstants.programDetailRoute);
    }

    return GestureDetector(
      onTap: _handleViewDetails,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.zero),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 180, 235, 175).withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.zero),
              border: Border.all(
                color: const Color.fromARGB(255, 175, 241, 163),
                width: 1.0,
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtonapply(
    String text,
    BuildContext context,
    Program program,
  ) {
    void _handleApplyNow() {
      context.read<ProgramBloc>().add(SelectProgram(program));
      context.push(AppConstants.registrationRoute);
    }

    return GestureDetector(
      onTap: _handleApplyNow,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.zero),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 180, 235, 175).withOpacity(0.2),
              border: Border.all(
                color: const Color.fromARGB(255, 175, 241, 163),
                width: 1.0,
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramBloc, ProgramState>(
      builder: (context, state) {
        Widget content;

        if (state is ProgramLoading) {
          // Use the fake programs from ProgramLoading state for skeleton loading
          content = _buildProgramsGrid(
            state.fakePrograms,
            isLoading: true,
            onApplyNow: (program) {
              context.read<ProgramBloc>().add(SelectProgram(program));
              context.push(AppConstants.registrationRoute);
            },
            onViewDetails: (Program program) {
              (program) {
                context.read<ProgramBloc>().add(SelectProgram(program));
                context.push(AppConstants.programDetailRoute);
              };
            },
          );
        } else if (state is ProgramError) {
          content = _buildErrorState('Failed to load programs');
        } else if (state is ProgramLoaded) {
          if (state.programs.isEmpty) {
            content = _buildEmptyState();
          } else {
            content = _buildProgramsGrid(
              state.programs,
              onApplyNow: (program) {
                context.read<ProgramBloc>().add(SelectProgram(program));
                context.push(AppConstants.registrationRoute);
              },
              onViewDetails: (Program program) {
                (program) {
                  context.read<ProgramBloc>().add(SelectProgram(program));
                  context.push(AppConstants.registrationRoute);
                };
              },
            );
          }
        } else {
          // Initial state - show loading
          content = _buildLoadingState();
        }

        return Scaffold(
          // appBar: AppBar(title: const Text('Programs'), elevation: 0),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<ProgramBloc>().add(const RefreshPrograms());
              await Future.delayed(const Duration(milliseconds: 100));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dear applicant, Before commencing the online applying procedure, please take 20 minutes and read carefully the following documents. Please make sure you fully understand the requirements and screening criteria through the entire process, and that you are certain you will be able to meet them.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                top: 8,
                                bottom: 8,
                              ),
                              child: Text(
                                'BMLAETO26 candidate check list for enrollment.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Download'),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),
                    const Text(
                      'Available Programs',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    content,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
