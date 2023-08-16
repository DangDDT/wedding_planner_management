import '../../../../core/core.dart';

abstract class FirebaseMessagingService {
  static final tag = {AppCore.tag, 'FirebaseMessagingService'}.join('_');

  Future<void> requestPermissions();
  Future<String> get token;
}
