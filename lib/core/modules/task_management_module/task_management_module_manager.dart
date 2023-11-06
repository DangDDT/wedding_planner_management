import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:task_management_module/core/module_configs.dart';
import 'package:task_management_module/core/task_management_module.dart';
import 'package:user_module/core/user_module.dart';
import 'package:wedding_planner_management/core/core.dart';
import 'package:wedding_planner_management/src/infrastructure/local_notification/local_notification_service.dart';

class TaskManagementModuleManager {
  static List<GetPage> routes = TaskManagementModule.pageRoutes;

  static Future<void> init() async {
    await TaskManagementModule.init(
      isShowLog: kDebugMode,
      baseUrlConfig: BaseUrlConfig(
        baseUrl: '',
      ),
      authConfig: AuthConfig(
        accessToken: () async => "",
        onRefreshTokenCallback: () async => "",
      ),
      onCreateLocalNotificationCallback: (id, title, body, at) async {
        try {
          await NotificationService().showNotification(
            id,
            title,
            body,
            at,
          );
        } catch (e, stackTrace) {
          Logger.log(
            e.toString(),
            name: 'onCreateLocalNotificationCallback',
            stackTrace: stackTrace,
          );
        }
      },
    );
  }

  static Future<void> login({
    required AppUserModel appUser,
  }) async {
    List<ListTaskTab> listTaskTab = [];
    switch (appUser.role) {
      case Role.partner:
        listTaskTab = [
          ListTaskTab.all(),
          ListTaskTab.expected(),
          ListTaskTab.toDo(),
          ListTaskTab.inProgress(),
          ListTaskTab.done(),
        ];
        break;
      case Role.staff:
        listTaskTab = [
          ListTaskTab.all(),
          ListTaskTab.toDo(),
          ListTaskTab.inProgress(),
          ListTaskTab.done(),
        ];
        break;
      default:
        break;
    }
    await TaskManagementModule.login(
      userConfig: UserConfig(
        userId: appUser.id,
        fullName: appUser.fullName,
        avatar: appUser.avatar,
      ),
      listTaskTabs: listTaskTab,
    );
  }

  static Future<void> logout() async {
    await TaskManagementModule.logout();
  }
}
