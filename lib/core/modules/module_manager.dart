import 'package:user_module/core/user_module.dart';
import 'package:wedding_planner_management/core/core.dart';

import 'task_management_module/task_management_module_manager.dart';

class ModuleManager {
  static Future<void> initializeModules() async {
    await Future.wait([
      UserModuleManager.init(),
      TaskManagementModuleManager.init(),
    ]);
  }

  static Future<void> loginModules({
    required AppUserModel appUser,
  }) async {
    await Future.wait([
      TaskManagementModuleManager.login(appUser: appUser),
    ]);
  }

  static Future<void> logoutModules() async {
    await Future.wait([
      TaskManagementModuleManager.logout(),
    ]);
  }
}
