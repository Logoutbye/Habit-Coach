// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class LocalNotifications {
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   static final onClickNotification = BehaviorSubject<String>();

// // on tap on any notification
//   static void onNotificationTap(NotificationResponse notificationResponse) {
//     onClickNotification.add(notificationResponse.payload!);
//   }

// // initialize the local notifications
//   static Future init() async {
//     // Ensure that time zones are initialized
//     tz.initializeTimeZones();

//     // initialise the plugin. app_icon needs to be added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       onDidReceiveLocalNotification: (id, title, body, payload) => null,
//     );
//     final LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       linux: initializationSettingsLinux,
//     );
//     _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onNotificationTap,
//       onDidReceiveBackgroundNotificationResponse: onNotificationTap,
//     );
// // permissions
//     // _flutterLocalNotificationsPlugin
//     //     .resolvePlatformSpecificImplementation<
//     //         AndroidFlutterLocalNotificationsPlugin>()!
//     //     .pendingNotificationRequests();
//     // _flutterLocalNotificationsPlugin
//     //     .resolvePlatformSpecificImplementation<
//     //         AndroidFlutterLocalNotificationsPlugin>()!
//     //     .requestPermission();
//   }

// // // initialize the local notifications
// //   static Future init() async {
// //     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
// //     const AndroidInitializationSettings initializationSettingsAndroid =
// //         AndroidInitializationSettings('@mipmap/ic_launcher');
// //     final DarwinInitializationSettings initializationSettingsDarwin =
// //         DarwinInitializationSettings(
// //       onDidReceiveLocalNotification: (id, title, body, payload) => null,
// //     );
// //     final LinuxInitializationSettings initializationSettingsLinux =
// //         LinuxInitializationSettings(defaultActionName: 'Open notification');
// //     final InitializationSettings initializationSettings =
// //         InitializationSettings(
// //             android: initializationSettingsAndroid,
// //             iOS: initializationSettingsDarwin,
// //             linux: initializationSettingsLinux);
// //     _flutterLocalNotificationsPlugin.initialize(initializationSettings,
// //         onDidReceiveNotificationResponse: onNotificationTap,
// //         onDidReceiveBackgroundNotificationResponse: onNotificationTap);
// //   }

//   // show a simple notification
//   static Future showSimpleNotification({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await _flutterLocalNotificationsPlugin
//         .show(0, title, body, notificationDetails, payload: payload);
//   }

//   // schedule a local notification based on provided date and time
//   static Future scheduleLocalNotification({
//     required int id,
//     required String title,
//     required String body,
//     required tz.TZDateTime scheduledDate,
//     required String payload,
//   }) async {
//     tz.initializeTimeZones();
//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       scheduledDate,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'channel 4',
//           'your channel name',
//           channelDescription: 'your channel description',
//           importance: Importance.max,
//           priority: Priority.high,
//           ticker: 'ticker',
//         ),
//       ),
//       androidScheduleMode: AndroidScheduleMode.exact,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       payload: payload,
//     );
//   }

//   // to schedule a local notification
//   static Future showScheduleNotification({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     tz.initializeTimeZones();
//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//         2,
//         title,
//         body,
//         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//         const NotificationDetails(
//             android: AndroidNotificationDetails(
//                 'channel 3', 'your channel name',
//                 channelDescription: 'your channel description',
//                 importance: Importance.max,
//                 priority: Priority.high,
//                 ticker: 'ticker')),
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         payload: payload);
//   }

//   // to show periodic notification at regular interval
//   static Future showPeriodicNotifications({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails('channel 2', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     await _flutterLocalNotificationsPlugin.periodicallyShow(
//         1, title, body, RepeatInterval.everyMinute, notificationDetails,
//         payload: payload);
//   }

//   // close a specific channel notification
//   static Future cancel(int id) async {
//     await _flutterLocalNotificationsPlugin.cancel(id);
//   }

//   // close all the notifications available
//   static Future cancelAll() async {
//     await _flutterLocalNotificationsPlugin.cancelAll();
//   }

  
// }


//                   //  LocalNotifications.showSimpleNotification(
//                   //     title: "Simple Notification",
//                   //     body: "This is a simple notification",
//                   //     payload: "This is simple data");
//                   // LocalNotifications.showScheduleNotification(
//                   //     title: "Schedule Notification",
//                   //     body: "This is a Schedule Notification",
//                   //     payload: "This is schedule data");
//                   // LocalNotifications.showPeriodicNotifications(
//                   //     title: "Periodic Notification",
//                   //     body: "This is a Periodic Notification",
//                   //     payload: "This is periodic data");











import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTap,
    );
  }

  static Future _onNotificationTap(
      NotificationResponse notificationResponse) async {
    // Handle notification tap event
  }

  static Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  static Future<void> scheduleLocalNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    required String payload,
  }) async {
    tz.initializeTimeZones();
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel 4',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }
}
