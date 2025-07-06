import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/widgets/bullet_text.dart';
import 'package:flutter/material.dart';

class RejectedPage extends StatefulWidget {
  const RejectedPage({super.key});

  @override
  State<RejectedPage> createState() => _RejectedPageState();
}

class _RejectedPageState extends State<RejectedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rejected')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children:  [
            Text('Application Declined', style: boldTextStyle.copyWith(color: AppConstants.eslRed)),
            const SizedBox(height: 20),
            const Text('We appreciate your interest in joining Babogaya Maritime & Logistics Academy.'),
            const SizedBox(height: 20),
            const Text('After careful consideration, we regret to inform you that your application does not meet our current eligibility criteria and cannot be accepted at this time.'),
            const SizedBox(height: 30),
            const Text('Need help or want to improve your chances?', style: boldTextStyle),
            const SizedBox(height: 20),
            const Text('You may:'),
            const SizedBox(height: 10),
            const BulletText(space: 20, text: 'Review the eligibility criteria and reapply in the next intake period.',),
            const SizedBox(height: 10),
            const BulletText(space: 20, text: 'Contact our admissions team at admissions@esles.et for more details or support.'),
            const SizedBox(height: 10),
            const Text('We encourage you to stay connected and explore future opportunities with us.')
          ],
        ),
      ),
    );
  }
}
