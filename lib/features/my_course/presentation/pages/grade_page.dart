import 'dart:ui';

import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/shared/table_data.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/widgets/table_with_yellow_column.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class GradePage extends StatefulWidget {
  const GradePage({super.key});

  @override
  State<GradePage> createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  TableData<String>? weeklyScheduleTableData;
  Map<String, List<String>>? gradesTableData;
  @override
  void initState() {
    super.initState();
  }


  final Map<String, List<String>> gradesData = {
    'CODE': ['Course',  'Grade', 'Grade Point'],
    'MT210': ['Marine Engineering', '78', 'PASS'],
    'MT220': ['Marine Engineering', '81', 'PASS'],
    'NS101': ['Navigation', '87', 'PASS'],
    'APP220': ['Applied Physics', '92', 'PASS'],
    'ME260': ['Marine Engineering', '63', 'FAIL'],
    'MT230': ['Marine English', '71', 'PASS'],
    'ET110': ['Ethics & Law', '69', 'FAIL'],
  };

  final Map<String, String> summaryData = {
    'Semester GPA': '3.5',
    'Cumulative GPA': '3.5',
    'Total Semester Credits': '18',
    'Total Credits Completed': '54',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Grade Report', style: boldTextStyle),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(FluentIcons.arrow_download_16_regular),
                    label: const Text('Transcript'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppConstants.eslGrey,
                      textStyle: const TextStyle(fontSize: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierColor: Colors.black87,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            child: InteractiveViewer(
                              boundaryMargin: const EdgeInsets.all(20),
                              minScale: 0.5,
                              maxScale: 4.0,
                              child: Hero(
                                tag: AppConstants.certificate,
                                transitionOnUserGestures: true,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    AppConstants.certificate,
                                    height: 400,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Hero(
                    tag: AppConstants.certificate,
                    transitionOnUserGestures: true,
                    child: Image.asset(AppConstants.certificate, height: 400),
                  ),
                ),
              ),
              const Text(
                'Track your academic progress and performance across all enrolled courses.',
              ),
             
              const SizedBox(height: 20),
              TableWithYellowColumn(data: gradesData),
              
              const SizedBox(height: 20),
              const Text('Download Course Resources', style: boldTextStyle),
              const SizedBox(height: 10),
              const Text(
                'Easily download lecture notes, assignments, guides, and reading materials to stay on track with your studies.',
              ),
              const SizedBox(height: 20),
             
              const DownloadDocumentContainer(
                documentName: 'Candidate checklist for Enrollment English',
              ),
              const DownloadDocumentContainer(
                documentName: 'Candidate checklist for Enrollment English',
              ),
              const DownloadDocumentContainer(
                documentName: 'Candidate checklist for Enrollment English',
              ),
              const DownloadDocumentContainer(
                documentName: 'Candidate checklist for Enrollment English',
              ),
              const DownloadDocumentContainer(
                documentName: 'Candidate checklist for Enrollment English',
              ),
              const DownloadDocumentContainer(
                documentName: 'Candidate checklist for Enrollment English',
              ),
              const SizedBox(height: 10),
              const Text('Assignments', style: boldTextStyle),
              
              const DownloadDocumentContainer(
                documentName: 'Candidate checklist for Enrollment English',
              ),
              const DownloadDocumentContainer(
                documentName: 'Candidate checklist for Enrollment English',
              ),
              const DownloadDocumentContainer(
                documentName: 'Candidate checklist for Enrollment English',
              ),
              const DownloadDocumentContainer(
                documentName: 'Candidate checklist for Enrollment English',
              ),
              const DownloadDocumentContainer(
                documentName: 'Candidate checklist for Enrollment English',
              ),
              const DownloadDocumentContainer(
                documentName: 'Candidate checklist for Enrollment English',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DownloadDocumentContainer extends StatelessWidget {
  const DownloadDocumentContainer({super.key, required this.documentName});
  final String documentName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(color: AppConstants.eslGreyTint),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(documentName),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(FluentIcons.eye_16_regular),
                label: const Text('Read Document'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(FluentIcons.arrow_download_16_regular),
                label: const Text('Download'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BlurryBackgroundWidget extends StatelessWidget {
  const BlurryBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: currentThemeNotifier.value == lightMode
                ? Colors.white
                : AppConstants.eslDarkGreyTint,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Certificate',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'This is to certify that',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'has successfully completed the course',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Marine Engineering',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Date: 20th October 2023',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Download Certificate'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
