import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/widgets/bullet_text.dart';
import 'package:flutter/material.dart';

class PendingPage extends StatefulWidget {
  const PendingPage({super.key});

  @override
  State<PendingPage> createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pending')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: const [
            Text('Application Under Review', style: boldTextStyle),
            SizedBox(height: 20),
            Text('Thank you for submitting your application to Babogaya Maritime & Logistics Academy.'),
            SizedBox(height: 20),
            Text('Your information has been successfully received and is currently under review by our admissions team.'),
            SizedBox(height: 30),
            Text("What's Next?", style: boldTextStyle),
            SizedBox(height: 20),
            Text('Once your application has been assessed, you will receive one of the following:'),
            SizedBox(height: 10),
            BulletText(space: 20, text: 'An invoice and payment instructions to proceed with enrollment, or',),
            SizedBox(height: 10),
            BulletText(space: 20, text: 'A decline notification with feedback if your application does not meet eligibility criteria.'),
            SizedBox(height: 10),
            Text('We appreciate your patience during this process. You will receive an update via email or through your dashboard within 3–5 working days.')
          ],
        ),
      ),
    );
  }
}
