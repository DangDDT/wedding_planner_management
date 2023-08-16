import 'package:get/get.dart';

import '../../src/presentation/page/home/home_page.dart';
import '../modules/user_module/user_module_manager.dart';
import 'router_constant.dart';

class AppRouter {
  static final pageRoutes = <GetPage>[
    GetPage(
      name: RouterConstants.home,
      page: () => const HomePage(),
      // middlewares: [
      //   AuthMiddleware(),
      //   LockMiddleware(),
      // ],
    ),
    ...UserModuleManager.routes,
  ];
}
