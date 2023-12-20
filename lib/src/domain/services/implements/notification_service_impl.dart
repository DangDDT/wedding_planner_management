import 'package:get/get.dart';
import 'package:wedding_planner_management/src/domain/mappers/z_mapper.dart';
import 'package:wedding_planner_management/src/domain/models/notification_data_model.dart';
import 'package:wedding_planner_management/src/domain/services/interfaces/i_notifcation_service.dart';
import 'package:wss_repository/wss_repository.dart';

class NotificationServiceImpl implements INotificationService {
  final repo = Get.find<INotificationRepository>();
  @override
  Future<List<NotificationDataModel>> getNotifications({
    required int? page,
    required int? limit,
    required String userId,
  }) async {
    final data = await repo.getNotifications(
      param: GetNotificationParam(
        page: page,
        pageSize: limit,
        userId: userId,
        sortKey: null,
        sortOrder: null,
        dateFrom: null,
        dateTo: null,
      ),
    );

    if (data.baseDatas == null || data.baseDatas?.isEmpty == true) {
      return [];
    }

    return Mapper.instance.mapListData(data.baseDatas!);
  }

  @override
  Future<void> markAsRead({required String notificationId}) {
    return repo.updateNotificationStatus(
      id: notificationId,
      param: PatchReadNotificationParam(status: 'Read'),
    );
  }
}
