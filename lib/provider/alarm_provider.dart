import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../Services/sqllite_services.dart';

class AlarmProvider extends ChangeNotifier {
  SqliteServiceProvider obj1 = SqliteServiceProvider();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  List<DateTime> _alarms = [];

  List<DateTime> get alarms => _alarms;

  AlarmProvider() {
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void addAlarm(DateTime dateTime) {
    _alarms.add(dateTime);
    _scheduleAlarm(dateTime);
    notifyListeners();

    obj1.addTasks(alaram_list: _alarms);
  }

  void removeAlarm(DateTime dateTime) {
    _alarms.remove(dateTime);
    cancelNotification(dateTime);
    notifyListeners();
  }

  void _scheduleAlarm(DateTime dateTime) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'alarm_notif_channel',
      'Alarm notifications',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('your_sound'),
      enableVibration: true,
      timeoutAfter: 5000,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      dateTime.millisecondsSinceEpoch ~/ 1000,
      'Alarm',
      'It\'s time!',
      tz.TZDateTime.from(dateTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotification(DateTime dateTime) async {
    int notificationId = dateTime.millisecondsSinceEpoch ~/ 1000;
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
