import 'dart:async';
import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../../environment.dart';
import '../../domain/services/firebase/firebase_crashlytic_service.dart';

class FirebaseCrashlyticsRepository implements FirebaseCrashlyticsService {
  FirebaseCrashlyticsRepository({
    FirebaseCrashlytics? firebaseCrashlytics,
    Environment? environment,
  })  : _firebaseCrashlytics =
            firebaseCrashlytics ?? FirebaseCrashlytics.instance,
        _environment = environment ?? Environment.dev;

  final FirebaseCrashlytics _firebaseCrashlytics;
  final Environment _environment;

  @override
  void init() {
    if (_environment.isProd) {
      FlutterError.onError = _firebaseCrashlytics.recordFlutterFatalError;
    }
  }

  @override
  Future<void> disableCollectionEnabledOnDebugMode() async {
    if (kDebugMode) {
      // Force disable Crashlytics collection while doing every day development.
      await _firebaseCrashlytics.setCrashlyticsCollectionEnabled(false);
    } else {
      await _firebaseCrashlytics.setCrashlyticsCollectionEnabled(true);
      // Handle Crashlytics enabled status when not in Debug,
      // e.g. allow your users to opt-in to crash reporting.
    }
  }

  @override
  Future<void> recordError(Object exception, StackTrace? stackTrace,
      {bool fatal = true}) async {
    await FirebaseCrashlytics.instance
        .recordError(exception, stackTrace, fatal: fatal);
  }

  @override
  FutureOr<dynamic> callBackWrapper(
    FutureOr<dynamic> function,
  ) async {
    try {
      await function;
    } catch (e, stackTrace) {
      log('CrashlyticsService Wrapper', error: e, stackTrace: stackTrace);
      await _firebaseCrashlytics.recordError(
        e,
        stackTrace,
      );
    }
  }
}
