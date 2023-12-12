import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:wedding_planner_management/core/modules/user_module/user_module_manager.dart';
import 'package:wedding_planner_management/src/domain/mappers/profiles/notification_data_mapper.dart';
import 'package:wedding_planner_management/src/domain/mappers/z_mapper.dart';
import 'package:wedding_planner_management/src/domain/services/firebase/firebase_authentication_service.dart';
import 'package:wedding_planner_management/src/domain/services/implements/notification_service_impl.dart';
import 'package:wedding_planner_management/src/domain/services/interfaces/i_notifcation_service.dart';
import 'package:wedding_planner_management/src/infrastructure/repositories/firebase_authentication_repository.dart';
import 'package:wss_repository/wss_repository.dart';

import '../../environment.dart';
import '../../src/domain/services/apis/base_api_service.dart';
import '../../src/domain/services/firebase/firebase_crashlytic_service.dart';
import '../../src/domain/services/firebase/firebase_messaging_service.dart';
import '../../src/infrastructure/infrastructure.dart';
import '../../src/infrastructure/repositories/base_api_repository.dart';
import '../../src/infrastructure/repositories/firebase_crashlytic_repository.dart';
import '../../src/infrastructure/repositories/firebase_messaging_repository.dart';
import 'core_uri/core_uri.dart';
import 'global_controller.dart';

class GlobalBinding {
  static void setUpLocator({
    required Environment environment,
  }) {
    Mapper.instance.registerMappers([
      NotificationDataMapper(),
    ]);
    Get.put<FirebaseMessagingService>(
      FirebaseMessagingRepository(),
      permanent: true,
    );
    Get.put<FirebaseAuthenticationService>(
      FirebaseAuthenticationRepository(
        firebaseAuth: FirebaseAuth.instance,
        environment: environment,
      ),
    );

    Get.put<FirebaseCrashlyticsService>(
      FirebaseCrashlyticsRepository(
        firebaseCrashlytics: FirebaseCrashlytics.instance,
        environment: environment,
      ),
      tag: FirebaseCrashlyticsService.tag,
    );

    Get.put<FirebaseMessagingService>(
      FirebaseMessagingRepository(
        firebaseMessaging: FirebaseMessaging.instance,
      ),
      tag: FirebaseMessagingService.tag,
    );

    final coreUri = Get.put<CoreUri>(
      CoreUri(
        environment: environment,
      ),
      tag: CoreUri.tag,
    );

    final dioClient = Get.put<DioClient>(
      DioClient(
        baseUrl: coreUri.appBaseUrl,
      ),
      tag: DioClient.tag,
    );

    WssRepository.init(
      isShowDioLogger: true,
      authConfig: AuthConfig(
        accessToken: () => UserModuleManager.getAccessToken,
        onRefreshTokenCallback: null,
        onUnauthorizedCallback: null,
      ),
    );

    Get.put<INotificationService>(
      NotificationServiceImpl(),
    );

    // Get.put<BaseApiClient>(
    //   BaseApiClient(),
    //   tag: BaseApiClient.tag,
    // );

    // Get.put<IsarService>(IsarManager(), tag: IsarService.tag);

    Get.put<BaseApiService>(BaseApiRepository(), tag: BaseApiService.tag);

    Get.put(AppController(), tag: AppController.tag);
  }
}
