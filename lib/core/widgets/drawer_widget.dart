import 'dart:ui';

import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  // Helper method to build menu items
  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required IconData filledIcon,
    required String route,
    required String title,
    bool requiresAuth = false,
    bool isAuthenticated = false,
  }) {
    final currentLocation = GoRouter.of(context).state.matchedLocation;
    final isActive = currentLocation == route;
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isActive
            ? AppConstants.eslGreen.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isActive ? AppConstants.eslGreen : Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(
            isActive ? filledIcon : icon,
            color: isActive ? Colors.white : Colors.grey[800],
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: isActive
                ? AppConstants.eslGreen
                : theme.textTheme.bodyLarge?.color,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          if (requiresAuth && !isAuthenticated) {
            context.replace(AppConstants.loginRoute);
          } else {
            context.replace(route);
          }
          // Close the drawer after a short delay for better UX
          Future.delayed(const Duration(milliseconds: 150), () {
            if (context.mounted) {
              Scaffold.of(context).closeDrawer();
            }
          });
        },
      ),
    );
  }

  // Build user profile section
  Widget _buildUserProfile(BuildContext context, dynamic user) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey[100]
            : Colors.grey[900],
        borderRadius: BorderRadius.all(Radius.zero),
        border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppConstants.eslGreen, width: 2),
            ),
            child: const CircleAvatar(
              radius: 24,
              backgroundColor: AppConstants.eslGreen,
              child: Icon(
                FluentIcons.person_20_filled,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.firstName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  user.email ?? '',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              FluentIcons.sign_out_24_regular,
              color: AppConstants.eslRed,
              size: 24,
            ),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthLogOutRequested());
              context.replace(AppConstants.homeRoute);
              if (context.mounted) {
                Scaffold.of(context).closeDrawer();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final isAuthenticated = authState is Authenticated;
        final user = isAuthenticated ? (authState as Authenticated).user : null;
        final isStudent =
            user?.role == 'STUDENT' ||
            user?.role == 'USER' ||
            user?.role == 'ADMIN';

        // Calculate the width of the drawer (85% of screen width)
        final screenWidth = MediaQuery.of(context).size.width;
        final drawerWidth = screenWidth * 0.85;

        return Container(
          width: drawerWidth,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(5, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with background image
              Container(
                width: double.infinity,
                height: 180, // Fixed height for the header
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  image: const DecorationImage(
                    image: AssetImage(AppConstants.students),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    top: 60,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        isAuthenticated ? 'Welcome back' : 'Welcome',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (isAuthenticated && user != null) ...[
                        // const SizedBox(height: 8),
                        // Text(
                        //   user.firstName,
                        //   style: const TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 24,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // const SizedBox(height: 4),
                        // Text(
                        //   user.email ?? '',
                        //   style: TextStyle(
                        //     color: Colors.white.withOpacity(0.9),
                        //     fontSize: 14,
                        //   ),
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ] else ...[
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            context.replace(AppConstants.loginRoute);
                            if (context.mounted) {
                              Scaffold.of(context).closeDrawer();
                            }
                          },

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 4.0,
                                sigmaY: 4.0,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                child: Text(
                                  'Sign In',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Menu items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  children: [
                    _buildMenuItem(
                      context: context,
                      icon: FluentIcons.home_24_regular,
                      filledIcon: FluentIcons.home_24_filled,
                      route: AppConstants.homeRoute,
                      title: 'Home',
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: FluentIcons.book_24_regular,
                      filledIcon: FluentIcons.book_24_filled,
                      route: AppConstants.programsRoute,
                      title: 'Programs',
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: FluentIcons.library_24_regular,
                      filledIcon: FluentIcons.library_24_filled,
                      route: AppConstants.libraryRoute,
                      title: 'Library',
                      requiresAuth: true,
                      isAuthenticated: isAuthenticated,
                    ),
                    _buildMenuItem(
                      context: context,
                      icon: FluentIcons.image_24_regular,
                      filledIcon: FluentIcons.image_24_filled,
                      route: AppConstants.galleryRoute,
                      title: 'Gallery',
                    ),
                    if (isAuthenticated) ...[
                      const Divider(height: 2),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          'My Account',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      if (isStudent)
                        _buildMenuItem(
                          context: context,
                          icon: FluentIcons.grid_24_regular,
                          filledIcon: FluentIcons.grid_24_filled,
                          route: AppConstants.myCoursesRoute,
                          title: 'My Courses',
                        ),
                      _buildMenuItem(
                        context: context,
                        icon: FluentIcons.person_feedback_24_regular,
                        filledIcon: FluentIcons.person_feedback_24_filled,
                        route: AppConstants.feedbackRoute,
                        title: 'Feedback',
                      ),
                    ],
                    _buildMenuItem(
                      context: context,
                      icon: FluentIcons.settings_24_regular,
                      filledIcon: FluentIcons.settings_24_filled,
                      route: AppConstants.settingsRoute,
                      title: 'Settings',
                    ),
                  ],
                ),
              ),
              if (isAuthenticated && user != null)
                _buildUserProfile(context, user),
            ],
          ),
        );
      },
    );
  }
}
