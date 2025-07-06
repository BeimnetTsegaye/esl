import 'package:esl/core/loaders/loading_widget.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:esl/features/auth/presentation/widgets/k_text_field.dart';
import 'package:esl/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc _profileBloc;

  final TextEditingController _oldPWController = TextEditingController();
  final TextEditingController _newPWController = TextEditingController();
  final TextEditingController _confirmPWController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  void toggleObscureOldPassword() {
    setState(() {
      obscureOldPassword = !obscureOldPassword;
    });
  }

  void toggleObscureNewPassword() {
    setState(() {
      obscureNewPassword = !obscureNewPassword;
    });
  }

  void toggleObscureConfirmPassword() {
    setState(() {
      obscureConfirmPassword = !obscureConfirmPassword;
    });
  }

  @override
  void initState() {
    super.initState();
    _profileBloc = context.read<ProfileBloc>();
  }

  @override
  void dispose() {
    _oldPWController.dispose();
    _newPWController.dispose();
    _confirmPWController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogOutSuccess || state is AuthUnsupportedRoleLogout) {
          context.go(AppConstants.loginRoute);
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: LoadingWidget());
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ChangePasswordLoading) {
                  return const Center(child: LoadingWidget());
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const Center(child: LoadingWidget());
                        }
                        if (state is Authenticated) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: AppConstants.eslGreen,
                            ),
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundColor: AppConstants.eslYellow,
                                  child: Icon(
                                    FluentIcons.person_20_filled,
                                    size: 50,
                                    color: AppConstants.eslWhite,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.user.firstName,
                                  style: const TextStyle(
                                    color: AppConstants.eslWhite,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  state.user.email,
                                  style: const TextStyle(
                                    color: AppConstants.eslWhite,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          );
                        }
                        return Container(
                          decoration: const BoxDecoration(
                            color: AppConstants.eslGreen,
                          ),
                          padding: const EdgeInsets.all(20),
                          child: const Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: AppConstants.eslYellow,
                                child: Icon(
                                  FluentIcons.person_20_filled,
                                  size: 50,
                                  color: AppConstants.eslWhite,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'BMLA',
                                style: TextStyle(
                                  color: AppConstants.eslWhite,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'bmla@gmail.com',
                                style: TextStyle(color: AppConstants.eslWhite),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Preferences',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppConstants.eslGrey,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: currentThemeNotifier.value == lightMode
                                    ? AppConstants.eslGreyTint
                                    : AppConstants.eslDarkGreyTint,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(FluentIcons.alert_24_filled),
                            ),
                            trailing: const Icon(
                              FluentIcons.chevron_right_24_regular,
                            ),
                            title: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Notifications', style: boldTextStyle),
                                Text(
                                  'Enabled',
                                  style: TextStyle(color: AppConstants.eslGrey),
                                ),
                              ],
                            ),
                            onTap: () {
                              // Handle notifications selection
                            },
                          ),
                          ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: currentThemeNotifier.value == lightMode
                                    ? AppConstants.eslGreyTint
                                    : AppConstants.eslDarkGreyTint,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                FluentIcons.dark_theme_24_filled,
                              ),
                            ),
                            title: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Dark Mode', style: boldTextStyle),
                              ],
                            ),
                            trailing: ValueListenableBuilder<ThemeData>(
                              valueListenable: currentThemeNotifier,
                              builder: (context, currentTheme, child) {
                                return Switch(
                                  value: currentTheme == darkMode,
                                  onChanged: (value) {
                                    currentThemeNotifier.value = value
                                        ? darkMode
                                        : lightMode;
                                  },
                                );
                              },
                            ),
                            onTap: () {
                              // Handle dark mode selection
                            },
                          ),
                          const Text(
                            'Security Settings',
                            style: TextStyle(
                              fontSize: 20,
                              color: AppConstants.eslGrey,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            tileColor: currentThemeNotifier.value == lightMode
                                ? AppConstants.eslGreyTint
                                : AppConstants.eslDarkGreyTint,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            leading: const Text(
                              'Change Password',
                              style: TextStyle(fontSize: 16),
                            ),

                            trailing: const Icon(
                              FluentIcons.chevron_right_24_regular,
                            ),
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                shape: const RoundedRectangleBorder(),
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            spacing: 10,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              KTextField(
                                                controller: _oldPWController,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                labelText: 'Current Password',
                                                obscureText: obscureOldPassword,
                                                onSuffixIconPressed: () {
                                                  setState(() {
                                                    obscureOldPassword =
                                                        !obscureOldPassword;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Current password is required';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              KTextField(
                                                controller: _newPWController,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                labelText: 'New Password',
                                                obscureText: obscureNewPassword,
                                                onSuffixIconPressed: () {
                                                  setState(() {
                                                    obscureNewPassword =
                                                        !obscureNewPassword;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'New password is required';
                                                  }
                                                  if (value.length < 6) {
                                                    return 'Password must be at least 6 characters';
                                                  }
                                                  if (value ==
                                                      _oldPWController.text) {
                                                    return 'New password cannot be the same as current password';
                                                  }
                                                  if (!RegExp(
                                                    r'^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{6,}$',
                                                  ).hasMatch(value)) {
                                                    return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              KTextField(
                                                controller:
                                                    _confirmPWController,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                labelText:
                                                    'Confirm New Password',
                                                obscureText:
                                                    obscureConfirmPassword,
                                                onSuffixIconPressed: () {
                                                  setState(() {
                                                    obscureConfirmPassword =
                                                        !obscureConfirmPassword;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please confirm your new password';
                                                  }
                                                  if (value !=
                                                      _newPWController.text) {
                                                    return 'Passwords do not match';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _profileBloc.add(
                                                      ChangePassword(
                                                        currentPassword:
                                                            _oldPWController
                                                                .text,
                                                        newPassword:
                                                            _newPWController
                                                                .text,
                                                      ),
                                                    );
                                                    Navigator.pop(context);
                                                    _oldPWController.clear();
                                                    _newPWController.clear();
                                                    _confirmPWController
                                                        .clear();
                                                  }
                                                },
                                                child: const Text(
                                                  'Change Password',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            tileColor: currentThemeNotifier.value == lightMode
                                ? AppConstants.eslGreyTint
                                : AppConstants.eslDarkGreyTint,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            leading: const Text(
                              'Privacy Policy and Terms of Use',
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: const Icon(
                              FluentIcons.chevron_right_24_regular,
                            ),
                            onTap: () {},
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            tileColor: currentThemeNotifier.value == lightMode
                                ? AppConstants.eslGreyTint
                                : AppConstants.eslDarkGreyTint,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            leading: const Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppConstants.eslRed,
                              ),
                            ),
                            trailing: const Icon(
                              FluentIcons.sign_out_24_regular,
                            ),
                            onTap: () {
                              context.read<AuthBloc>().add(
                                const AuthLogOutRequested(),
                              );
                              context.replace(AppConstants.homeRoute);
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text('App Info'),
                          const SizedBox(height: 20),
                          const Text('App Version', style: boldTextStyle),
                          const Text('Build v1.0.0'),
                          const SizedBox(height: 10),
                          const Text('Developer', style: boldTextStyle),
                          Row(
                            children: [
                              Image.asset(
                                AppConstants.koket,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Koket Investment',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
