import 'package:esl/core/services/onboarding_service.dart';
import 'package:esl/core/shared/base_page.dart';
import 'package:esl/core/shared/chat_page.dart';
import 'package:esl/core/shared/constants.dart';
import 'package:esl/core/shared/splash_screen.dart';
import 'package:esl/core/shared/unknown_page.dart';
import 'package:esl/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:esl/features/auth/presentation/pages/login_page.dart';
import 'package:esl/features/auth/presentation/pages/new_password_page.dart';
import 'package:esl/features/auth/presentation/pages/otp_page.dart';
import 'package:esl/features/auth/presentation/pages/reset_password_page.dart';
import 'package:esl/features/auth/presentation/pages/signup_page.dart';
import 'package:esl/features/gallery/presentation/pages/gallery_page.dart';
import 'package:esl/features/home/domain/entities/news.dart';
import 'package:esl/features/home/presentation/pages/academics_calendar_page.dart';
import 'package:esl/features/home/presentation/pages/esl_payment_page.dart';
import 'package:esl/features/home/presentation/pages/feedback_page.dart';
import 'package:esl/features/home/presentation/pages/home_page.dart';
import 'package:esl/features/home/presentation/pages/notifications_page.dart';
import 'package:esl/features/home/presentation/pages/payment_receipt_page.dart';
import 'package:esl/features/home/presentation/pages/qr_scanner_page.dart';
import 'package:esl/features/home/presentation/pages/tuition_page.dart';
import 'package:esl/features/library/presentation/pages/library_page.dart';
import 'package:esl/features/library/presentation/pages/news_detail.dart';
import 'package:esl/features/my_course/presentation/pages/grade_page.dart';
import 'package:esl/features/my_course/presentation/pages/my_programs_page.dart';
import 'package:esl/features/my_course/presentation/pages/pending_page.dart';
import 'package:esl/features/my_course/presentation/pages/registration_page.dart';
import 'package:esl/features/my_course/presentation/pages/registration_success_step.dart';
import 'package:esl/features/my_course/presentation/pages/rejected_page.dart';
import 'package:esl/features/mydorm/presentation/pages/mydorm_page.dart';
import 'package:esl/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:esl/features/profile/presentation/pages/profile_page.dart';
import 'package:esl/features/program/domain/entities/program.dart';
import 'package:esl/features/program/presentation/pages/program_detail_page.dart';
import 'package:esl/features/program/presentation/pages/programs_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const UnknownPage(),
  redirect: (context, state) async {
    final authState = context.read<AuthBloc>().state;
    final onBoarded = await hasSeenOnboarding();

    // Handle splash screen
    if (state.matchedLocation == '/') {
      if (!onBoarded) {
        return AppConstants.homeRoute;
      }

      if (authState is AuthInitial || authState is AuthChecking) {
        return AppConstants.baseRoute;
      }

      if (authState is Authenticated) {
        return AppConstants.homeRoute;
      }

      return AppConstants.homeRoute;
    }

    if (state.matchedLocation == AppConstants.onboardingRoute) {
      return null;
    }

    if (state.matchedLocation == AppConstants.baseRoute) {
      return null;
    }

    if (authState is AuthInitial || authState is AuthChecking) {
      return AppConstants.baseRoute;
    }

    if (authState is AuthSignUpSuccess &&
        state.matchedLocation == AppConstants.loginRoute) {
      return null;
    }

    if (authState is AuthFailure ||
        authState is AuthLogOutSuccess ||
        authState is AuthUnsupportedRoleLogout) {
      if ([
        AppConstants.libraryRoute,
        AppConstants.myCoursesRoute,
        AppConstants.myDormRoute,
        AppConstants.qrScannerRoute,
        AppConstants.profileRoute,
      ].contains(state.matchedLocation)) {
        return AppConstants.loginRoute;
      }
      return null;
    }

    if (authState is Authenticated) {
      if ([
        AppConstants.loginRoute,
        AppConstants.registerRoute,
      ].contains(state.matchedLocation)) {
        return AppConstants.homeRoute;
      }
      return null;
    }

    return null;
  },
  routes: [
    GoRoute(
      path: AppConstants.baseRoute,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppConstants.onboardingRoute,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AppConstants.loginRoute,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppConstants.registerRoute,
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: AppConstants.resetPasswordRoute,
      builder: (context, state) => const ResetPasswordPage(),
    ),
    GoRoute(
      path: AppConstants.setNewPasswordRoute,
      builder: (context, state) => const NewPasswordPage(),
    ),
    GoRoute(
      path: AppConstants.otpVerificationRoute,
      builder: (context, state) => const OtpPage(),
    ),
    ShellRoute(
      builder: (context, state, child) => BasePage(child: child),
      routes: [
        GoRoute(
          path: AppConstants.homeRoute,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppConstants.programsRoute,
          builder: (context, state) => const ProgramsPage(),
        ),
        GoRoute(
          path: AppConstants.libraryRoute,
          builder: (context, state) => const LibraryPage(),
        ),
        GoRoute(
          path: AppConstants.galleryRoute,
          builder: (context, state) => const GalleryPage(),
        ),

        GoRoute(
          path: AppConstants.qrScannerRoute,
          builder: (context, state) => const QRScannerPage(),
        ),
        GoRoute(
          path: AppConstants.myCoursesRoute,
          builder: (context, state) => const MyProgramsPage(),
        ),
        GoRoute(
          path: AppConstants.profileRoute,
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: AppConstants.myDormRoute,
          builder: (context, state) => const MyDormPage(),
        ),
      ],
    ),
    GoRoute(
      path: AppConstants.programDetailRoute,
      builder: (context, state) => const ProgramDetailPage(),
    ),
    // Other routes
    GoRoute(
      path: AppConstants.chatbotRoute,
      builder: (context, state) => const ChatPage(),
    ),
    GoRoute(
      path: AppConstants.notificationsRoute,
      builder: (context, state) => const NotificationsPage(),
    ),
    GoRoute(
      path: AppConstants.gradeRoute,
      builder: (context, state) => const GradePage(),
    ),
    GoRoute(
      path: AppConstants.registrationRoute,
      builder: (context, state) =>
          RegistrationPage(program: state.extra as Program?),
    ),
    GoRoute(
      path: AppConstants.successRoute,
      builder: (context, state) => const RegistrationSuccessPage(),
    ),
    GoRoute(
      path: AppConstants.pendingRoute,
      builder: (context, state) => const PendingPage(),
    ),
    GoRoute(
      path: AppConstants.rejectedRoute,
      builder: (context, state) => const RejectedPage(),
    ),
    GoRoute(
      path: AppConstants.academicRoute,
      builder: (context, state) => const AcademicsCalendarPage(),
    ),

    GoRoute(
      path: AppConstants.tuitionRoute,
      builder: (context, state) => const TuitionPage(),
    ),
    GoRoute(
      path: AppConstants.eslPaymentRoute,
      builder: (context, state) => const EslPaymentPage(),
    ),
    GoRoute(
      path: AppConstants.paymentReceiptRoute,
      builder: (context, state) => const PaymentReceiptPage(),
    ),
    GoRoute(
      path: AppConstants.newsDetailsRoute,
      builder: (context, state) => NewsDetail(news: state.extra as News?),
    ),
    GoRoute(
      path: AppConstants.feedbackRoute,
      builder: (context, state) => const FeedbackPage(),
    ),
  ],
);
