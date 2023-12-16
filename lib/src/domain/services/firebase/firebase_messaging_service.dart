import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/core.dart';

abstract class FirebaseMessagingService {
  AuthorizationStatus? get authorizationStatus;
  static final tag = {AppCore.tag, 'FirebaseMessagingService'}.join('_');

  Future<void> requestPermissions();
  Future<String> get token;
  Future<void> subscribeToTopic(String topic);
  Future<void> unsubscribeFromTopic(String topic);
}
