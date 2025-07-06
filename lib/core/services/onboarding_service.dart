import 'package:shared_preferences/shared_preferences.dart';

const String _hasSeenOnboardingKey = 'has_seen_onboarding';

Future<bool> hasSeenOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_hasSeenOnboardingKey) ?? false;
}

Future<void> markOnboardingAsSeen() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_hasSeenOnboardingKey, true);
}
