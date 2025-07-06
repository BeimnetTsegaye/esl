import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UnknownPage extends StatefulWidget {
  const UnknownPage({super.key});

  @override
  State<UnknownPage> createState() => _UnknownPageState();
}

class _UnknownPageState extends State<UnknownPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              if (currentThemeNotifier.value == lightMode)
                AppConstants.eslWhite
              else
                AppConstants.eslGrey,
              if (currentThemeNotifier.value == lightMode)
                AppConstants.eslGrey..withValues(alpha: 0.1)
              else
                AppConstants.eslGrey..withValues(alpha: 0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated 404 text
              ScaleTransition(
                scale: _scaleAnimation,
                child: Text(
                  '404',
                  style: TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.bold,
                    color: currentThemeNotifier.value == lightMode
                        ? AppConstants.eslGrey
                        : AppConstants.eslWhite,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Animated icon
              ScaleTransition(
                scale: _scaleAnimation,
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 100,
                  color: currentThemeNotifier.value == lightMode
                      ? AppConstants.eslGrey
                      : AppConstants.eslWhite,
                ),
              ),
              const SizedBox(height: 30),
              // Message
              Text(
                'Oops! Page Not Found',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: currentThemeNotifier.value == lightMode
                      ? AppConstants.eslGrey
                      : AppConstants.eslWhite,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        currentThemeNotifier.value == lightMode
                              ? AppConstants.eslGrey.withValues(alpha: 0.7)
                              : AppConstants.eslWhite
                          ..withValues(alpha: 0.7),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNavigationButton(
                    icon: Icons.arrow_back,
                    label: 'Go Back',
                    onTap: () => context.pop(),
                  ),
                  const SizedBox(width: 20),
                  _buildNavigationButton(
                    icon: Icons.home,
                    label: 'Go Home',
                    onTap: () => context.replace(AppConstants.homeRoute),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: currentThemeNotifier.value == lightMode
                  ? AppConstants.eslGrey.withValues(alpha: 0.3)
                  : AppConstants.eslWhite.withValues(alpha: 0.3),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: currentThemeNotifier.value == lightMode
                    ? AppConstants.eslGrey
                    : AppConstants.eslWhite,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: currentThemeNotifier.value == lightMode
                      ? AppConstants.eslGrey
                      : AppConstants.eslWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
