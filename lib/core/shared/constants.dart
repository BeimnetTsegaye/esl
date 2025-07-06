import 'dart:ui';

class AppConstants {
  //?assets
  //images
  static const String engAbbrivationFullColor =
      'assets/ENG-Abbriviation-FullColor.png';
  static const String engHorizontalFullColor =
      'assets/ENG-Horizontal-FullColor.png';
  static const String engAbbrivationWhite$WhiteLOGO =
      'assets/ENG-Abbriviation-Greyscale-White.png';
  static const String engHorizontalGrey$GreyLOGO =
      'assets/ENG-Abbriviation-Greyscale-Grey.png';
  static const String shipImage = 'assets/ship.png';
  static const String userImage = 'assets/user.png';
  static const String students = 'assets/students.png';
  static const String send = 'assets/send.svg';
  static const String chatBot = 'assets/bot.svg';
  static const String googleLogo = 'assets/google_logo.png';
  static const String wheel = 'assets/wheel.png';
  static const String koket = 'assets/koket.png';
  static const String certificate = 'assets/certificate.png';

  //colors
  static const Color eslGreen = Color(0xFF006C32); // ESL Green
  static const Color eslYellow = Color(0xFFF8CA10); // ESL Yellow
  static const Color eslRed = Color(0xFFCC2027); // ESL Red
  static const Color eslGreenTint = Color(0xFF99C0a6); // ESL Green Tint
  static const Color eslGreyTint = Color(0xFFEDEDEE); // ESL Grey Tint
  static const Color eslDarkGreyTint = Color(
    0xFF6D6D6D,
  ); // ESL Grey Tint for dark mode
  static const Color eslGrey = Color(0xFF414042); // ESL Grey text on secondary
  static const Color eslWhite = Color(0xFFFFFFFF); // White text on primary
  static const Color eslGreyText = Color(
    0xFFEDEDED,
  ); // ESL Grey Tint text on secondary

  //routes
  static const String onboardingRoute = '/onboarding';
  //?auth
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String resetPasswordRoute = '/reset-password';
  static const String setNewPasswordRoute = '/set-new-password';
  static const String otpVerificationRoute = '/otp-verification';

  //?base
  static const String baseRoute = '/base';
  //?home
  static const String homeRoute = '/';
  static const String chatbotRoute = '/chatbot';
  static const String notificationsRoute = '/notifications';

  //?drawer
  static const String academicRoute = '/academic-calendar';
  static const String partnersRoute = '/partners';
  static const String galleryRoute = '/gallery';
  static const String qrScannerRoute = '/qr-scanner';
  static const String feedbackRoute = '/feedback';
  static const String tuitionRoute = '/tuition';
  static const String programsRoute = '/programs';
  static const String programDetailRoute = '/program-details';
  static const String gradeRoute = '/grade';
  static const String myCoursesRoute = '/mycourses';
  static const String myDormRoute = '/mydorm';

  //?courses
  static const String registrationRoute = '/registration';
  static const String successRoute = '/success';
  static const String pendingRoute = '/pending';
  static const String rejectedRoute = '/rejected';

  //?library
  static const String libraryRoute = '/library';
  static const String newsDetailsRoute = '/news-details';

  //?profile
  static const String profileRoute = '/profile';
  static const String changePasswordRoute = '/change-password';
  static const String settingsRoute = '/settings';
  static const String termsAndConditionsRoute = '/terms-and-conditions';

  //?esl
  static const String eslPaymentRoute = '/esl-payment';
  static const String paymentReceiptRoute = '/payment-receipt';

  // Images
  static const String logo = 'assets/logo.png';
}
