import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../core/core.dart';
import '../../domain/services/firebase/firebase_messaging_service.dart';

class FirebaseMessagingRepository implements FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging;
  AuthorizationStatus? _authorizationStatus;

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

    _authorizationStatus = settings?.authorizationStatus;

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

  @override
  Future<void> subscribeToTopic(String topic) {
    return _firebaseMessaging.subscribeToTopic(topic);
  }

  @override
  AuthorizationStatus? get authorizationStatus => _authorizationStatus;

  @override
  Future<void> unsubscribeFromTopic(String topic) {
    return _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
