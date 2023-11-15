import 'package:flutter/material.dart';
import 'package:healthy_routine/core/routings/routes.dart';
import 'package:healthy_routine/models/routine.dart';
import 'package:healthy_routine/services/local_notification.dart';
import 'package:healthy_routine/state/onboarding_screen__indicator_provider.dart';
import 'package:healthy_routine/controllers/get_schedule_provider.dart';
import 'package:healthy_routine/state/selected_day_provider.dart';
import 'package:healthy_routine/state/task_provider.dart';
import 'package:healthy_routine/state/timer_provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'core/app_strings.dart';
import 'core/routings/routes_name.dart';
import 'state/create_fixed_routine_indicator_provider.dart';
import 'state/drop_down_provider.dart';
import 'state/toggle_provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OnBoardingScreenIndicatorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SwitchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TimeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateFixedScreenIndicatorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TodoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DropdownProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ScheduleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedDaysProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: ThemeData(
          fontFamily: 'Nunito',
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF495CC5)),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

initilizedApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  await Hive.initFlutter();
  Hive.registerAdapter(RoutineAdapter());
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Routine>(AppStrings.routineHiveBox);
}

