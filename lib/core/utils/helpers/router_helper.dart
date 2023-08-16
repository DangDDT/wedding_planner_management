import 'package:get/get.dart';

class RouterHelper {
  static String getCurrentRoute(String currentRoute) {
    String currentRoute = Get.currentRoute;
    currentRoute = currentRoute.substring(0, currentRoute.length - 1);
    return currentRoute;
  }
}
