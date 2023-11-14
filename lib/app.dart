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






// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   @override
//   void initState() {
//     // listenToNotifications();
//     super.initState();
//   }

// //  to listen to any notification clicked or not
//   // listenToNotifications() {
//   //   print("Listening to notification");
//   //   LocalNotifications.onClickNotification.stream.listen((event) {
//   //     Navigator.push(context,
//   //         MaterialPageRoute(builder: (context) => AnotherPage(payload: event)));
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Flutter Local Notifications")),
//       body: Container(
//         height: double.infinity,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton.icon(
//                 icon: Icon(Icons.notifications_outlined),
//                 onPressed: () {
//                   LocalNotifications.showSimpleNotification(
//                       title: "Simple Notification",
//                       body: "This is a simple notification",
//                       payload: "This is simple data");
//                 },
//                 label: Text("Simple Notification"),
//               ),
//               ElevatedButton.icon(
//                 icon: Icon(Icons.timer_outlined),
//                 onPressed: () {
//                   LocalNotifications.showPeriodicNotifications(
//                       title: "Periodic Notification",
//                       body: "This is a Periodic Notification",
//                       payload: "This is periodic data");
//                 },
//                 label: Text("Periodic Notifications"),
//               ),
//               ElevatedButton.icon(
//                 icon: Icon(Icons.timer_outlined),
//                 onPressed: () {
//                   LocalNotifications.showScheduleNotification(
//                       title: "Schedule Notification",
//                       body: "This is a Schedule Notification",
//                       payload: "This is schedule data");
//                 },
//                 label: Text("Schedule Notifications"),
//               ),
//               // to close periodic notifications
//               ElevatedButton.icon(
//                   icon: Icon(Icons.delete_outline),
//                   onPressed: () {
//                     LocalNotifications.cancel(1);
//                   },
//                   label: Text("Close Periodic Notifcations")),
//               ElevatedButton.icon(
//                   icon: Icon(Icons.delete_forever_outlined),
//                   onPressed: () {
//                     LocalNotifications.cancelAll();
//                   },
//                   label: Text("Cancel All Notifcations"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
