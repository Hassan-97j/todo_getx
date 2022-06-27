import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo_getx/modals/tasks.dart';
import 'package:todo_getx/ui/notified_page.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    //tz.initializeTimeZones();
    configureLocalTimeZone();
 final IOSInitializationSettings initializationSettingsIOS =
     IOSInitializationSettings(
         requestSoundPermission: false,
         requestBadgePermission: false,
         requestAlertPermission: false,
         onDidReceiveLocalNotification: onDidReceiveLocalNotification
     );


   const AndroidInitializationSettings initializationSettingsAndroid =
       AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
       iOS: initializationSettingsIOS,
       android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: selectNotification);

  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page

    Get.dialog(
      const Text('welcome'),
    );
    
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
       // ignore: avoid_print
       print('notification payload: $payload');
    } else {
       // ignore: avoid_print
       print("Notification Done");
    }
    if (payload == "Theme Changed"){

    }else{
      Get.to(()=> NotifiedPage(label: payload));
    }
     
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  
  displayNotification({required String title, required String body,}) async {
     // ignore: avoid_print
     print("doing test");
    var androidPlatformChannelSpecifics =  const AndroidNotificationDetails(
        "your channel id", "your channel name", 
       // "your channel description",
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics =  const IOSNotificationDetails();
    var platformChannelSpecifics =  NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }

  scheduledNotification(int hour, int minutes, Task task) async {
     await flutterLocalNotificationsPlugin.zonedSchedule(
         task.id!.toInt(),
         task.title,
         task.note,
         convertTime(hour,minutes),
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
         const NotificationDetails(
             android: AndroidNotificationDetails('your channel id',
            'your channel name',
           // 'your channel description',
          ),
        ),
         androidAllowWhileIdle: true,
         uiLocalNotificationDateInterpretation:
             UILocalNotificationDateInterpretation.absoluteTime,
             matchDateTimeComponents: DateTimeComponents.time,
             payload: "${task.title}|""${task.note}|"
             );

   }

   tz.TZDateTime convertTime(int hour, int minutes){
     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
     tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
     if(scheduledDate.isBefore(now)){
       scheduledDate = scheduledDate.add(const Duration(days: 1));
     }
     return scheduledDate;
   }

   Future<void> configureLocalTimeZone() async {
     tz.initializeTimeZones();
     final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
     tz.setLocalLocation(tz.getLocation(timeZone));
   }

}