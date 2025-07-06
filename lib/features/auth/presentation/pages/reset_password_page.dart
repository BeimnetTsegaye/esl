import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/auth/presentation/widgets/k_text_field.dart';
import 'package:esl/features/auth/presentation/widgets/logo_with_clip.dart';
import 'package:esl/features/auth/presentation/widgets/title_message.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LogoWithClip(),
            const SizedBox(height: 40),
            authTitleMessage(
              title: 'Reset Password',
              message: 'Enter your information to reset your password',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      helperText: 'enter your email address',
                      suffixIcon: TextButton(
                        child: Text(
                          'Send OTP',
                          style: boldTextStyle.copyWith(
                            color: AppConstants.eslGrey,
                          ),
                        ),
                        onPressed: () {
                          // You can add functionality here if needed
                        },
                      ),
                    ),
                  ),
                  KTextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    helperText: 'OTP has been sent to your email',
                    labelText: 'OTP',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      context.push(AppConstants.setNewPasswordRoute),
                  child: const Text('Continue'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.eslGrey,
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(color: Colors.white),
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
