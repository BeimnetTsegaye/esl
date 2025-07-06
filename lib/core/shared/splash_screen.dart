import 'package:esl/core/shared/constants.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _rotateAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure || state is AuthUnsupportedRoleLogout) {
          context.go(AppConstants.homeRoute);
        } else if (state is Authenticated) {
          context.go(AppConstants.homeRoute);
        }
      },
      child: Scaffold(
        backgroundColor: AppConstants.eslWhite,
        body: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([_controller, _fadeController]),
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: RotationTransition(
                  turns: _rotateAnimation,
                  child: Image.asset(
                    AppConstants.wheel,
                    width: 100,
                    height: 100,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
