import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/sqllite_services.dart';
import '../provider/alarm_provider.dart';

class AlarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final alarmProvider = Provider.of<AlarmProvider>(context);

    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<Map>>(
            future: SqliteServiceProvider.getAllDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              final tasks = snapshot.data ?? [];
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    color: Colors.transparent,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 2,
                    child: ListTile(
                      title: Text(
                        "Date: ${task['DateTime'].toString().substring(0, 10)}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(.8),
                        ),
                      ),
                      subtitle: Text(
                        "Time: ${task['DateTime'].toString().substring(10, 16)}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(.8),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete,
                            color: Colors.white.withOpacity(.8)),
                        onPressed: () async {
                          await SqliteServiceProvider.deleteTask(task['id']);
                          // Force rebuild to reflect changes
                          alarmProvider.notifyListeners();
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            onPressed: () async {
              // Show date picker
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (picked != null) {
                // Show time picker
                TimeOfDay? timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (timeOfDay != null) {
                  // Combine date and time into a single DateTime object
                  final dateTime = DateTime(
                    picked.year,
                    picked.month,
                    picked.day,
                    timeOfDay.hour,
                    timeOfDay.minute,
                  );
                  // alarmProvider.addAlarm(dateTime);

                  final alarmSettings = AlarmSettings(
                    id: 42,
                    dateTime: dateTime,
                    assetAudioPath:
                        'assets/Tic-Tac-Mechanical-Alarm-Clock-2-chosic.com_.mp3',
                    loopAudio: true,
                    vibrate: true,
                    volume: 0.8,
                    fadeDuration: 3.0,
                    notificationTitle: 'You have an alarm set for $dateTime)',
                    notificationBody: "Want to stop? Go to the app...",
                  );
                  await Alarm.set(alarmSettings: alarmSettings);
                  alarmProvider.addAlarm(dateTime);
                }
              }
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.grey
                        .withOpacity(0.1); // Adjust opacity as needed
                  }
                  return null; // No overlay color when not hovered
                },
              ),
            ),
            child: Text(
              'Add Alarm',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: ElevatedButton(
            onPressed: () {
              Alarm.stop(42);
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.grey
                        .withOpacity(0.1); // Adjust opacity as needed
                  }
                  return null; // No overlay color when not hovered
                },
              ),
            ),
            child: Text(
              'Stop',
              style: TextStyle(
                color: Colors.white, // Text color
              ),
            ),
          ),
        ),
      ],
    );
  }
}
