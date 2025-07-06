
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

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool obscure = true;

  // Future<void> googleSignIn() async {
  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn(
  //       clientId: Platform.isIOS
  //           ? '102307533237-plgje5po3l89sujf5gqotq3t73s06qbq.apps.googleusercontent.com'
  //           : '102307533237-cdvg6dof7e2sotjethohdgosahmvotdq.apps.googleusercontent.com',
  //       scopes: <String>['email', 'profile'],
  //     );

  //     final GoogleSignInAccount? googleUser = await googleSignIn.signOut();
  //     if (googleUser == null) {
  //       // User cancelled the sign-in flow
  //       return;
  //     }

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     // Here you should call your backend to authenticate with the Google tokens
  //     // ignore: use_build_context_synchronously
  //     context.read<AuthBloc>().add(
  //       AuthLogInRequested(
  //         email: googleUser.email,
  //         password: googleAuth.idToken ?? '', // Use idToken for authentication
  //         rememberMe: true,
  //       ),
  //     );
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Google Sign-In failed: $e'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.go(AppConstants.loginRoute);
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
                children: [
                  const LogoWithClip(),
                  authTitleMessage(
                    title: 'Sign Up',
                    message: 'Enter your information to create an account',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KTextField(
                          controller: firstNameController,
                          helperText: 'Enter your first name',
                          labelText: 'First Name',
                          validator: (value) {
                            final validators = Validator(
                              validators: [const RequiredValidator()],
                            );
                            return validators.validate(
                              label: 'First Name',
                              value: value,
                            );
                          },
                        ),
                        KTextField(
                          controller: lastNameController,
                          helperText: 'Enter your last name',
                          labelText: 'Last Name',
                          validator: (value) {
                            final validators = Validator(
                              validators: [const RequiredValidator()],
                            );
                            return validators.validate(
                              label: 'Last Name',
                              value: value,
                            );
                          },
                        ),
                        KTextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          helperText: 'example@email.com',
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
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          helperText: 'Enter your phone number',
                          labelText: 'Phone Number',
                          validator: (value) {
                            final validators = Validator(
                              validators: [
                                const RequiredValidator(),
                                const PhoneNumberValidator(),
                              ],
                            );
                            return validators.validate(
                              label: 'Phone Number',
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
                        KTextField(
                          controller: confirmController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscure,
                          onSuffixIconPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          helperText: 'Enter your password again',
                          labelText: 'Confirm Password',
                          validator: (value) {
                            final validators = Validator(
                              validators: [
                                const RequiredValidator(),
                                const MinLengthValidator(length: 8),
                                const MaxLengthValidator(length: 20),
                              ],
                            );
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            } else {
                              return validators.validate(
                                label: 'Confirm Password',
                                value: value,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'By signing up, you agree to our ',
                            style: authGreyTextStyle,
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: underlinedTextStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle Terms of Service tap
                              },
                          ),
                          const TextSpan(
                            text: ' and ',
                            style: authGreyTextStyle,
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: underlinedTextStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle Privacy Policy tap
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<AuthBloc>().add(
                              AuthSignUpRequested(
                                email: emailController.text,
                                password: passwordController.text,
                                phoneNumber: phoneNumberController.text,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                              ),
                            );
                          }
                        },
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      spacing: 10,
                      children: [
                        Expanded(child: Divider()),
                        Text('Or', style: authGreyTextStyle),
                        Expanded(child: Divider()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        //  async => await googleSignIn(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.eslGrey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Image.asset(AppConstants.googleLogo, height: 20),
                            const Text(
                              'Continue with Google',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Already have an account? ',
                            style: authGreyTextStyle,
                          ),
                          TextSpan(
                            text: 'Login',
                            style: underlinedTextStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.pushReplacement(
                                AppConstants.loginRoute,
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
