import 'package:wedding_planner_management/src/domain/mappers/base/base_data_mapper_profile.dart';
import 'package:wedding_planner_management/src/domain/mappers/z_mapper.dart';
import 'package:wedding_planner_management/src/domain/models/notification_data_model.dart';
import 'package:wss_repository/entities/notification.dart';

class NotificationDataMapper
    extends BaseDataMapperProfile<Notification, NotificationDataModel> {
  @override
  NotificationDataModel mapData(Notification entity, Mapper mapper) {
    return NotificationDataModel(
      id: entity.id ?? 'id-not-found-mapper',
      title: entity.title ?? 'No title',
      content: entity.content ?? 'No content',
      isRead: _checkIsRead(entity),
      createdAt: entity.createdAt ?? DateTime.now(),
    );
  }

  bool _checkIsRead(Notification data) {
    if (data.isRead?.toLowerCase().contains('read') == true) {
      return true;
    } else {
      return false;
    }
  }
}
