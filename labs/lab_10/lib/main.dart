import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/lab10_app.dart';
import 'features/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebaseIfAvailable();
  await NotificationService.instance.init();
  runApp(const Lab10App());
}

Future<void> _initializeFirebaseIfAvailable() async {
  try {
    await Firebase.initializeApp();
  } catch (error) {
    debugPrint('Firebase is not configured yet: $error');
  }
}
