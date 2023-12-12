import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:user_module/core/user_module.dart';
import 'package:wedding_planner_management/core/core.dart';
import 'package:wedding_planner_management/src/domain/services/firebase/firebase_authentication_service.dart';
import 'package:wedding_service_module/wedding_service_module.dart';

class ServiceModuleManager {
  static List<GetPage> routes = ServiceModuleManager.routes;
  static final _firebaseAuthenticationService =
      Get.find<FirebaseAuthenticationService>();

  static Future<void> init() async {
    await WeddingServiceModule.init(
      baseUrlConfig: BaseUrlConfig(
        baseUrl: DefaultConstants.baseUrl,
      ),
      isShowLog: kDebugMode,
    );
  }

  static Future<void> login({
    required AppUserModel appUser,
  }) async {
    await WeddingServiceModule.login(
      userConfig: UserConfig(
        userId: appUser.id,
      ),
      authConfig: AuthConfig(
        accessToken: () async => UserModule.getAccessToken,
        onRefreshTokenCallback: () async =>
            _firebaseAuthenticationService.refreshToken(),
      ),
      onGetMyCategoryCallback: () async => appUser.extraData['categoryId'],
    );
  }

  static Future<void> logout() async {
    await WeddingServiceModule.logout();
  }
}
