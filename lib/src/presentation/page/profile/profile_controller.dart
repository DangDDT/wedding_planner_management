import 'package:get/get.dart';
import 'package:wedding_planner_management/core/modules/user_module/user_module_manager.dart';

class ProfileController extends GetxController {
  Future<void> logout() async {
    await UserModuleManager.logout();
  }
}
