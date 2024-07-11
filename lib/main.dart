import 'package:alarm/alarm.dart' as alarm_package;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/provider/alarm_provider.dart';
import 'package:weatherapp/screens/bottomnavigation.dart';

import 'Services/sqllite_services.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await alarm_package.Alarm.init();
  await SqliteServiceProvider.initializeDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AlarmProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Alarm App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Homepage(),
      ),
    );
  }
}
