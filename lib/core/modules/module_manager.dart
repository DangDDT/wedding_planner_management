import 'package:get/get.dart';
import 'package:user_module/core/user_module.dart';
import 'package:wedding_planner_management/core/core.dart';
import 'package:wedding_planner_management/src/domain/services/firebase/firebase_messaging_service.dart';

import 'service_module/service_module_manager.dart';
import 'task_management_module/task_management_module_manager.dart';

class ModuleManager {
  static Future<void> initializeModules() async {
    await Future.wait([
      UserModuleManager.init(),
      TaskManagementModuleManager.init(),
      ServiceModuleManager.init(),
    ]);
  }

  static Future<void> loginModules({
    required AppUserModel appUser,
  }) async {
    final firebaseMessagingService = Get.find<FirebaseMessagingService>();
    await Future.wait([
      TaskManagementModuleManager.login(appUser: appUser),
      ServiceModuleManager.login(appUser: appUser),
      firebaseMessagingService.requestPermissions(),
    ]);
    await firebaseMessagingService.subscribeToTopic(appUser.id);
  }

  static Future<void> logoutModules() async {
    await Future.wait([
      TaskManagementModuleManager.logout(),
      ServiceModuleManager.logout(),
    ]);
  }
}
