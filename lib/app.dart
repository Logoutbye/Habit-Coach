import 'package:flutter/material.dart';
import 'package:healthy_routine/core/routings/routes.dart';
import 'package:healthy_routine/view/state/onboarding_screen_state.dart';
import 'package:healthy_routine/view/state/task_provider.dart';
import 'package:healthy_routine/view/state/timer_provider.dart';
import 'package:provider/provider.dart';
import 'core/app_strings.dart';
import 'core/routings/routes_name.dart';
import 'view/state/drop_down_provider.dart';
import 'view/state/toggle_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OnBoardingScreenState(),
        ),
        ChangeNotifierProvider(
          create: (context) => SwitchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TimeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateFixedScreenState(),
        ),
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DropdownProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7FD8D8)),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
