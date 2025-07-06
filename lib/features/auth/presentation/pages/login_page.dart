import 'package:esl/core/loaders/loading_widget.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:esl/features/auth/presentation/widgets/k_text_field.dart';
import 'package:esl/features/auth/presentation/widgets/logo_with_clip.dart';
import 'package:esl/features/auth/presentation/widgets/title_message.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/form_validation.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            final fromRegistration =
                GoRouterState.of(context).extra as bool? ?? false;
            if (fromRegistration) {
              context.pushReplacement(AppConstants.registrationRoute);
            } else {
              context.pushReplacement(AppConstants.homeRoute);
            }
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: LoadingWidget());
          }

          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 10,
                children: [
                  //logo
                  const SizedBox(height: 50),
                  const LogoWithClip(),
                  //welcome message
                  authTitleMessage(
                    title: 'Welcome Back',
                    message: 'Enter your credentials to continue',
                  ),

                  //textfields
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KTextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          helperText: 'bmla@esl.edu.et',
                          labelText: 'Email',
                          validator: (value) {
                            final validators = Validator(
                              validators: [
                                const RequiredValidator(),
                                const EmailValidator(),
                              ],
                            );
                            return validators.validate(
                              label: 'Email',
                              value: value,
                            );
                          },
                        ),
                        KTextField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscure,
                          onSuffixIconPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          helperText: 'Enter your password',
                          labelText: 'Password',
                          validator: (value) {
                            final validators = Validator(
                              validators: [
                                const RequiredValidator(),
                                const MinLengthValidator(length: 8),
                                const MaxLengthValidator(length: 20),
                              ],
                            );
                            return validators.validate(
                              label: 'Password',
                              value: value,
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  //forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (bool? value) {
                                setState(() {
                                  rememberMe = value ?? false;
                                });
                              },
                            ),

                            const Text('Remember me', style: authGreyTextStyle),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            context.push(AppConstants.resetPasswordRoute),
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: AppConstants.eslGrey),
                        ),
                      ),
                    ],
                  ),

                  //button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 12,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              AuthLogInRequested(
                                email: emailController.text,
                                password: passwordController.text,
                                rememberMe: rememberMe,
                              ),
                            );
                          }
                        },
                        child: const Text('Log In'),
                      ),
                    ),
                  ),

                  //signup
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Don't have an account? ",
                            style: authGreyTextStyle,
                          ),
                          TextSpan(
                            text: 'Sign Up',
                            style: underlinedTextStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.push(
                                AppConstants.registerRoute,
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
