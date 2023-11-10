import 'package:flutter/material.dart';
import 'package:healthy_routine/view/App%20Dashboard/view/app_dashboard_bottom_app_bar.dart';
import 'package:healthy_routine/view/Fixed%20Routines/view/create_fixed_routine_dashboard.dart';
import 'package:healthy_routine/view/Flexible%20Routines/view/create_flexible_routine_dashboard.dart';
import 'package:healthy_routine/view/App%20Dashboard/view/onboarding_screens.dart';

import '../../view/Fixed Routines/view/fixed_routine_dashboard.dart';
import '../../view/App Dashboard/view/splash_screen.dart';
import 'routes_name.dart';
import 'slide_transition_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final arguments = settings.arguments;
    switch (settings.name) {
      case RoutesName.splash:
        return SlideTransitionPage(page: const SplashScreen());
      case RoutesName.on_boarding_screen:
        return SlideTransitionPage(page: const OnBoardingScreens());
      case RoutesName.app_dashboard_bottom_app_bar:
        return SlideTransitionPage(page: const AppDashboardBottomAppBar());

      case RoutesName.fixed_routines_dashboard:
        return SlideTransitionPage(page: const FixedRoutinesDashboard());

      case RoutesName.create_flexible_routine:
        return SlideTransitionPage(
            page: const CreateFlexibleRoutineDashboard());
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
