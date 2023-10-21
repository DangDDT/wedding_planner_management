import 'package:get/get.dart';
import 'package:user_module/core/core.dart';
import 'package:wedding_planner_management/core/modules/task_management_module/task_management_module_manager.dart';
import 'package:wedding_planner_management/src/presentation/page/home/home_controller.dart';
import 'package:wedding_service_module/wedding_service_module.dart';

import '../../src/presentation/page/home/home_page.dart';
import '../modules/user_module/user_module_manager.dart';
import 'router_constant.dart';

class AppRouter {
  static final pageRoutes = <GetPage>[
    GetPage(
      name: RouterConstants.home,
      page: () => const HomePage(),
      middlewares: [
        AuthMiddleware(),
      ],
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(
          () => HomeController(),
        );
      }),
    ),
    ...UserModuleManager.routes,
    ...TaskManagementModuleManager.routes,
    ...WeddingServiceModule.pageRoutes,
  ];
}
