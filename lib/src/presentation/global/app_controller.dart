import 'dart:async';

import 'package:get/get.dart';
import 'package:wedding_planner_management/src/domain/models/notification_data_model.dart';
import 'package:wedding_planner_management/src/domain/services/interfaces/i_notifcation_service.dart';

import '../../../core/core.dart';

class AppController extends GetxController {
  static final String tag = {AppCore.tag, 'AppController'}.join('_');

  //Services
  final INotificationService _notificationService =
      Get.find<INotificationService>();

  ///States
  final notificationCount = 0.obs;
  final notifications = <NotificationDataModel>[].obs;

  @override
  void onInit() {
    getCountUnreadNotification();
    _intervalGetCountUnreadNotification();
    super.onInit();
  }

  Future<void> getCountUnreadNotification() async {
    final currentUser = UserModuleManager.currentUser;
    if (currentUser == null) {
      return;
    }
    final notifies = await _notificationService.getNotifications(
      page: null,
      limit: null,
      userId: currentUser.id,
    );
    notifications.value = notifies.where((e) => !e.isRead).toList();
    notificationCount.value = notifies.where((e) => !e.isRead).length;
  }

  Future<void> clearNotification() async {
    notifications.value = [];
    notificationCount.value = 0;
  }

  Future<void> _intervalGetCountUnreadNotification() async {
    Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        await getCountUnreadNotification();
      },
    );
  }
}
