import 'package:flutter/material.dart';
import 'package:healthy_routine/view/screens/create_fexible_routine_dashboard.dart';
import 'package:healthy_routine/view/screens/create_fixed_routine_dashboard.dart';
import 'package:healthy_routine/view/screens/onboarding_screens.dart';

import '../../view/screens/app_dashboard.dart';
import '../../view/screens/splash_screen.dart';
import 'routes_name.dart';
import 'slide_transition_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RoutesName.splash:
        return SlideTransitionPage(page: const SplashScreen());
      case RoutesName.on_boarding_screen:
        return SlideTransitionPage(page: const OnBoardingScreens());
      case RoutesName.app_dashboard:
        return SlideTransitionPage(page: const AppDashboard());
      case RoutesName.create_flexible_routine:
        return SlideTransitionPage(page: const CreateFlexibleRoutineDashboard());
      case RoutesName.create_fixed_routine:
        return SlideTransitionPage(page: const CreateFixedRoutineDashboard());
      default:
        return MaterialPageRoute(builder: (BuildContext) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: const Center(
                child: Text('No Page Route Defined'),
              ));
        });
    }
  }
}
