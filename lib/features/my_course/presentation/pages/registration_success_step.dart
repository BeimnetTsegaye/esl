import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/core/widgets/bullet_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationSuccessPage extends StatefulWidget {
  const RegistrationSuccessPage({super.key});

  @override
  State<RegistrationSuccessPage> createState() =>
      _RegistrationSuccessPageState();
}

class _RegistrationSuccessPageState extends State<RegistrationSuccessPage> {
  final List<String> _nextOptions = [
    'You will receive a confirmation email shortly.',
    'Application review typically takes 3–5 business days.',
    'If any additional documents or steps are required, we’ll notify you.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration', style: boldTextStyle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: AppConstants.eslGreen,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Registration Submitted Successful!',
              style: TextStyle(
                color: AppConstants.eslGreen,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Thank you for registering! Your application has been received and is currently under review by our admissions team.',
            ),
            const SizedBox(height: 20),
            const Text("What's Next?", style: boldTextStyle),
            const SizedBox(height: 10),
            ..._nextOptions.map((option) => BulletText(text: option)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: context.pop,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.eslGreen,
                foregroundColor: AppConstants.eslGreyText,
              ),
              child: const Text('Finish'),
            ),
          ],
        ),
      ),
    );
  }
}
