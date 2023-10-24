import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:user_module/core/core.dart';
import 'package:wedding_planner_management/core/core.dart';
import 'package:wedding_planner_management/src/domain/services/firebase/firebase_authentication_service.dart';

class UserModuleManager {
  static final FirebaseAuthenticationService _firebaseAuthenticationService =
      Get.find();

  static List<GetPage> routes = UserModule.pageRoutes;

  static AppUserModel? get currentUser => UserModule.currentUser;

  static Future<String?> get getAccessToken async => UserModule.getAccessToken;

  static Future<void> init() async {
    await UserModule.init(
      isShowLog: kDebugMode,

      ///MockData
      mockConfig: const MockConfig(
        role: Role.partner,
      ),
      baseUrlConfig: BaseUrlConfig(
        baseUrl: DefaultConstants.baseUrl,
      ),
      homeRoute: RouterConstants.home,
      onGetFirebaseTokenCallback: (email, password) async {
        try {
          final token =
              await _firebaseAuthenticationService.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          return token;
        } catch (e, stackTrace) {
          log(
            e.toString(),
            name: 'UserModuleManager - onGetFirebaseTokenCallback',
            stackTrace: stackTrace,
          );
          rethrow;
        }
      },
      viewConfig: LoginViewConfig(
        appName: 'Blissfull Bells',
        isShowRegisterButton: false,
        isShowForgotPasswordButton: false,
      ),
    );
  }

  static Future<void> logout() async {
    await UserModule.logout();
  }

  static Future<void> toEditProfilePage() async {
    await UserModule.toEditProfilePage();
  }
}
