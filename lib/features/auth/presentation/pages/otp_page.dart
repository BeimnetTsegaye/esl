import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/auth/presentation/widgets/logo_with_clip.dart';
import 'package:esl/features/auth/presentation/widgets/title_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LogoWithClip(),
            const SizedBox(height: 40),
            authTitleMessage(
              title: 'Welcome',
              message: 'Enter your credentials',
            ),
            const SizedBox(height: 25),
            //textfields
            const Pinput(length: 6),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(text: "Didn't receive code?\n "),
                  TextSpan(
                    text: 'Resend Code',
                    style: underlinedTextStyle,
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap =
                              () => context.pushReplacement(
                                AppConstants.setNewPasswordRoute,
                              ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            //button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      () => context.pushReplacement(AppConstants.loginRoute),
                  child: const Text('Log In'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
