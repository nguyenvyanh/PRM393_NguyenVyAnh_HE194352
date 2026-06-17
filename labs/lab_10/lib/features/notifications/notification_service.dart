import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(settings: settings);
    await requestPermission();
  }

  Future<void> requestPermission() async {
    final androidImplementation = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.requestNotificationsPermission();
  }

  Future<void> showLoginSuccessNotification({
    required String loginType,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'lab10_full_channel',
      'Lab10 Full Notifications',
      channelDescription: 'Notifications after successful login actions',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);
    await _plugin.show(
      id: 10,
      title: 'Login successful',
      body: 'You signed in successfully using $loginType.',
      notificationDetails: details,
    );
  }
}
