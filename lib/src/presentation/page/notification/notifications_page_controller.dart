import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_planner_management/core/modules/user_module/user_module_manager.dart';
import 'package:wedding_planner_management/src/domain/models/notification_data_model.dart';
import 'package:wedding_planner_management/src/domain/services/interfaces/i_notifcation_service.dart';

class NotificationsPageController extends GetxController {
  final notifyService = Get.find<INotificationService>();
  final limit = 10;
  late final PagingController<int, NotificationDataModel> _pagingController;
  PagingController<int, NotificationDataModel> get pagingController =>
      _pagingController;

  @override
  void onInit() {
    _pagingController = PagingController<int, NotificationDataModel>(
      firstPageKey: 0,
    )..addPageRequestListener(_fetchPage);
    super.onInit();
  }

  Future<void> markAsRead(NotificationDataModel notification) async {
    try {
      if (notification.isRead) {
        return;
      }
      await notifyService.markAsRead(notificationId: notification.id);
      notification = notification.copyWith(isRead: true);
      _pagingController.itemList = _pagingController.itemList!
          .map((e) => e.id == notification.id ? notification : e)
          .toList();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    final userId = UserModuleManager.currentUser?.id;
    if (userId == null) {
      return;
    }
    try {
      final newItems = await notifyService.getNotifications(
        page: pageKey,
        limit: limit,
        userId: userId,
        // userId: '43CCE28F-3759-4B4D-A865-D0C08295F05F',
      );
      final isLastPage = newItems.length < limit;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
