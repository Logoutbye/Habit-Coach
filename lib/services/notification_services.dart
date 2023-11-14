// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tzdata;

// class NotificationApi {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initializeNotifications() async {
//     tzdata.initializeTimeZones(); // Initialize time zones

//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );
//   }

//   static Future<void> showNotification(
//       {int id = 0, String? title, String? body}) async {
//     await flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       await _notificationDetails(),
//     );
//   }

//   static Future<NotificationDetails> _notificationDetails() async {
//     return NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channel id',
//         'channel name',
//         channelDescription: 'channel description',
//         importance: Importance.max,
//       ),
//     );
//   }

//   // Schedule a notification at a specific time
//   static Future<void> scheduleNotification({
//     required int id,
//     required String title,
//     required String body,
//     required tz.TZDateTime scheduledTime,
//   }) async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       scheduledTime,
//       await _notificationDetails(),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
// }

// // ... rest of your 