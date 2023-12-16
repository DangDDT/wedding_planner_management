import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wedding_planner_management/core/core.dart';
import 'package:wedding_planner_management/src/domain/enums/private/loading_enum.dart';
import 'package:wedding_planner_management/src/domain/models/notification_data_model.dart';
import 'package:wedding_planner_management/src/presentation/@shared/empty_handler.dart';
import 'package:wedding_planner_management/src/presentation/page/notification/notifications_page_controller.dart';

class NotificationsPage extends GetView<NotificationsPageController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
      ),
      body: Column(
        children: [
          const _NotificationPermissionStatus(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                controller.pagingController.refresh();
              },
              child: PagedListView<int, NotificationDataModel>.separated(
                pagingController: controller.pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<NotificationDataModel>(
                  itemBuilder: (context, item, index) {
                    return _NotificationWidget(
                      notification: item,
                      onTap: (notification) async {
                        await controller.markAsRead(notification);
                      },
                    );
                  },
                  firstPageErrorIndicatorBuilder: (context) =>
                      EmptyErrorHandler(
                    title: 'Có lỗi xảy ra',
                    description: 'Không thể tải dữ liệu',
                    reloadCallback: () => controller.pagingController.refresh(),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => EmptyErrorHandler(
                    banner: Icon(
                      Icons.notifications_off_outlined,
                      size: 100,
                      color: context.theme.colorScheme.primary.withOpacity(0.5),
                    ),
                    title: 'Không có thông báo',
                    description: 'Bạn chưa có thông báo nào',
                    reloadCallback: () => controller.pagingController.refresh(),
                  ),
                  noMoreItemsIndicatorBuilder: (context) =>
                      const SizedBox.shrink(),
                ),
                separatorBuilder: _buildDateSeparator,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// build date separator when date change from previous item with current item
  ///
  /// If no change, return Divider(height: 0, indent: 24)
  Widget _buildDateSeparator(BuildContext context, int index) {
    final notification = controller.pagingController.itemList![index];
    final previousNotification =
        index >= 1 ? controller.pagingController.itemList![index - 1] : null;
    final nextNotification =
        index < controller.pagingController.itemList!.length - 1
            ? controller.pagingController.itemList![index + 1]
            : null;
    if (previousNotification == null) {
      return const Divider(height: 0, indent: 24);
    }
    if (nextNotification == null) {
      return const SizedBox.shrink();
    }
    if (notification.createdAt.day != previousNotification.createdAt.day) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 24, 24, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.createdAt.toRecentlyStringDate(),
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      return const Divider(height: 0, indent: 24);
    }
  }
}

class _NotificationWidget extends StatelessWidget {
  const _NotificationWidget({
    required this.notification,
    required this.onTap,
  });
  final NotificationDataModel notification;
  final void Function(NotificationDataModel data) onTap;

  @override
  Widget build(BuildContext context) {
    final leading = _buildLeading(context);
    return InkWell(
      onTap: () => onTap(notification),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            leading,
            kGapW12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: notification.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                  Text(
                    notification.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  kGapH8,
                  Text(
                    notification.createdAt.toRecentlyStringFull(),
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            if (!notification.isRead)
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    IconData iconData = Icons.notifications;
    Color color = context.theme.colorScheme.primary;
    final content = notification.content.toLowerCase();
    if (content.contains('đơn hàng') && content.contains('tạo')) {
      iconData = Icons.add_shopping_cart_outlined;
      color = Colors.green;
    } else if (content.contains('đơn hàng') && content.contains('hủy')) {
      iconData = Icons.remove_shopping_cart_outlined;
      color = Colors.red;
    } else if (content.contains('task') && content.contains('tạo')) {
      iconData = Icons.add_task_outlined;
      color = Colors.green;
    }
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          iconData,
          color: color,
        ),
      ),
    );
  }
}

class _NotificationPermissionStatus
    extends GetView<NotificationsPageController> {
  const _NotificationPermissionStatus();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.permissionState.value.state != LoadingState.success) {
        return const SizedBox.shrink();
      }
      final isGranted = controller.permissionState.value.value ?? false;

      if (isGranted) {
        return const SizedBox.shrink();
      }

      return Container(
        color: context.theme.colorScheme.error.withOpacity(0.1),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: context.theme.colorScheme.error,
            ),
            kGapW12,
            Expanded(
              child: Text(
                'Để nhận thông báo, vui lòng cho phép ứng dụng truy cập vào thông báo.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.colorScheme.error,
                ),
              ),
            ),
            kGapW12,
            TextButton(
              onPressed: () async {
                await controller.requestPermission();
              },
              child: Text(
                'Cho phép',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
