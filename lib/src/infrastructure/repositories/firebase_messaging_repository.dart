import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../core/core.dart';
import '../../domain/services/firebase/firebase_messaging_service.dart';

class FirebaseMessagingRepository implements FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging;

  FirebaseMessagingRepository({
    FirebaseMessaging? firebaseMessaging,
  }) : _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance;

  @override
  Future<void> requestPermissions() async {
    NotificationSettings? settings;
    try {
      settings = await _firebaseMessaging.requestPermission();
    } catch (e, stackTrace) {
      Logger.log(e.toString(),
          name: 'FirebaseMessagingRepository.requestPermissions',
          stackTrace: stackTrace);
    }

    if (Platform.isIOS) {
      if (settings != null &&
          settings.authorizationStatus == AuthorizationStatus.authorized) {
        Logger.logInfo(
          'User granted permission',
          name: 'FirebaseMessagingRepository.requestPermissions',
        );
      } else {
        Logger.logInfo(
          'User declined or has not accepted permission',
          name: 'FirebaseMessagingRepository.requestPermissions',
        );
      }
    }
  }

  @override
  Future<String> get token async => await _firebaseMessaging.getToken() ?? '';
}
