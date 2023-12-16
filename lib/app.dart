import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:user_module/core/core.dart';

import 'core/core.dart';
import 'core/l10n/translator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Wedding Planner Management',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const CupertinoScrollBehavior(),
      getPages: AppRouter.pageRoutes,
      initialRoute: RouterConstants.home,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return LoaderOverlay(
          overlayColor: Colors.black.withOpacity(0.5),
          overlayWidget: const SpinKitFadingCircle(
            color: Colors.white,
            size: 48,
          ),
          child: child!,
        );
      },
      translations: Translator(),
      fallbackLocale: SupportedLocales.defaultLocale,
      locale: Get.deviceLocale,
      theme: CoreTheme.lightTheme,
      darkTheme: CoreTheme.darkTheme,
      supportedLocales: SupportedLocales.supportedLocales,
      transitionDuration: const Duration(milliseconds: 300),
      enableLog: kDebugMode,
      onInit: () async {
        UserModule.addAuthStateListener((previous, state) {
          ///Situation: User is unauthenticated and user(current) is null (Normal case)
          if (state.isUnthenticated && state.user == null) {
            Logger.logOK('[UserModule - Logout case] User is unauthenticated');
            ModuleManager.logoutModules();
          }

          ///Situation: User is unauthenticated and user(current) is has value (Abnormal case)
          else if (state.isUnthenticated && state.user != null) {
            Logger.logWarning(
              '[UserModule - Error case] User is unauthenticated, user is has value',
            );
          }

          ///Situation: User is unauthenticated and user(previous) is null (Normal case)
          else if (state.isUnthenticated && previous.user == null) {
            Logger.logOK('[UserModule - Login case] User is unauthenticated');
          }

          ///Situation: User is authenticated and user(current) is null (Abnormal case)
          else if (state.isAuthenticated && state.user == null) {
            Logger.logCritical(
                '[UserModule - Error case] User is authenticated, but user is null');
          }

          ///Situation: User is authenticated and user(current) is has value (Normal case)
          else if (state.isAuthenticated && state.user != null) {
            Logger.logOK('[UserModule - Try Login case] User is authenticated');
            ModuleManager.loginModules(appUser: state.user!.user);
          } else {
            Logger.logInfo('[UserModule - Other case]');
          }
        });
      },
    );
  }
}
