import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AcademicsCalendarPage extends StatefulWidget {
  const AcademicsCalendarPage({super.key});

  @override
  State<AcademicsCalendarPage> createState() => _AcademicsCalendarPageState();
}

class _AcademicsCalendarPageState extends State<AcademicsCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academics Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Academics Calendar', style: boldTextStyle),
            const Text('''
Welcome to the Academic Calendar page of Blue Maritime & Logistics Academy (BMLA). This calendar outlines the key academic dates, semester periods, registration deadlines, examination schedules, breaks, and graduation timelines for the current academic year.

Keeping track of important academic milestones ensures our cadets, students, faculty, and staff stay aligned and organized throughout the year.
        '''),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add your button action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.eslGreen,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: const Text('Download Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
