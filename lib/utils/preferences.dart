import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPreference {
  static const _key = 'hasFinishedOnboarding';

  Future<void> setFinished() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }

  Future<bool> isFinished() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }
}