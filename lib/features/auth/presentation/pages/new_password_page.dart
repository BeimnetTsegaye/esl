import 'package:esl/core/shared/constants.dart';
import 'package:esl/features/auth/presentation/widgets/k_text_field.dart';
import 'package:esl/features/auth/presentation/widgets/logo_with_clip.dart';
import 'package:esl/features/auth/presentation/widgets/title_message.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  TextEditingController newPWController = TextEditingController();
  TextEditingController confirmNewPWController = TextEditingController();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //logo
            const LogoWithClip(),
            const SizedBox(height: 40),
            //welcome message
            authTitleMessage(
              title: 'Set New Password',
              message: 'Enter your new password',
            ),

            //textfields
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KTextField(
                    controller: newPWController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscure,
                    onSuffixIconPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    labelText: 'New Password',
                    helperText: 'Enter your new password',
                  ),
                  KTextField(
                    controller: confirmNewPWController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscure,
                    onSuffixIconPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    labelText: 'Confirm New Password',
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
                  onPressed: () => context.go(AppConstants.loginRoute),
                  child: const Text('Reset Password'),
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
