import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'bootstrap.dart';
import 'environment.dart';
import 'firebase_options.dart';
import 'src/infrastructure/local_notification/local_notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    name: 'WPMS',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService().initNotification();
  tz.initializeTimeZones();

  await bootstrap(
    App.new,
    Environment.dev,
  );
}
