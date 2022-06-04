import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationObjectDetection {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    var android = const AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      icon: "@mipmap/ic_launcher",
      importance: Importance.max,
    );
    var ios = const IOSNotificationDetails();
    return NotificationDetails(
      android: android,
      iOS: ios,
    );
  }

  showNotification(List detectObejcts) async {
    await flutterLocalNotificationsPlugin.show(
        0,
        "Alerta",
        "Se a detectado ${detectObejcts.toString()}",
        await _notificationDetails());
  }
}
