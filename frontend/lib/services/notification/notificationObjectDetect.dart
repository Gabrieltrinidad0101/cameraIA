import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationObjectDetection {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  showNotification() async {
    var android = AndroidNotificationDetails('channel id', 'channel NAME',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.show(
        0, "New Notification", "I'm notification", platform,
        payload: "It works");
  }
}
