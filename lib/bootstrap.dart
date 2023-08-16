// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'core/app_core.dart';
import 'environment.dart';
import 'src/domain/services/firebase/firebase_crashlytic_service.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
  Environment environment,
) async {
  // AppAware.start();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await AppCore(environment: environment).init();

  final FirebaseCrashlyticsService crashlytics =
      Get.find<FirebaseCrashlyticsService>(
    tag: FirebaseCrashlyticsService.tag,
  );

  await runZonedGuarded(
    () async {
      runApp(await builder());
    },
    (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace, name: 'runZonedGuarded');
      crashlytics.recordError(error, stackTrace);
    },
  );
}
