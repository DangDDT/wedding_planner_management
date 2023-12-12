import 'package:wedding_planner_management/src/domain/models/notification_data_model.dart';

abstract interface class INotificationService {
  Future<List<NotificationDataModel>> getNotifications({
    required int page,
    required int limit,
    required String userId,
  });

  Future<void> markAsRead({
    required String notificationId,
  });
}
