import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationStorageService {
  static const String _storageKey = 'registration_form_data';
  static const String _currentStepKey = 'registration_current_step';
  static const String _programIdKey = 'registration_program_id';

  // Save registration form data
  static Future<void> saveFormData(Map<String, dynamic> formData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(formData));
  }

  // Load registration form data
  static Future<Map<String, dynamic>?> loadFormData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_storageKey);
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  // Save current step
  static Future<void> saveCurrentStep(int step) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_currentStepKey, step);
  }

  // Load current step
  static Future<int> loadCurrentStep() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_currentStepKey) ?? 0;
  }

  // Save program ID
  static Future<void> saveProgramId(String programId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_programIdKey, programId);
  }

  // Load program ID
  static Future<String?> loadProgramId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_programIdKey);
  }

  // Clear all registration data
  static Future<void> clearRegistrationData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    await prefs.remove(_currentStepKey);
    await prefs.remove(_programIdKey);
  }

  // Check if there's saved registration data
  static Future<bool> hasSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_storageKey);
  }
}
