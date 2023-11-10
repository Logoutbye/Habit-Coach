import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/routings/routes_name.dart';

class SplashServices with ChangeNotifier {
  Future<bool> saveToken(bool value, BuildContext context) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setBool('onboardingShown', value);
      Navigator.pushReplacementNamed(context, RoutesName.app_dashboard_bottom_app_bar);

      notifyListeners();
      return true; // Token saved successfully
    } catch (e) {
      print('Error saving: $e');
      return false; // Token not saved
    }
  }

  Future<void> checkIfOnboardingShown(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingShown = prefs.getBool('onboardingShown') ?? false;

    if (onboardingShown) {
      // Onboarding has been shown before, navigate to the home screen
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, RoutesName.app_dashboard_bottom_app_bar);
    } else {
      // Onboarding has not been shown, navigate to the onboarding screen
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacementNamed(context, RoutesName.on_boarding_screen);
    }
  }
}
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//                 prefs.setBool('onboardingShown', true);