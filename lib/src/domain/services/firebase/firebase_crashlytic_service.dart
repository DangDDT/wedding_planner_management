import 'dart:async';

import '../../../../core/core.dart';

abstract class FirebaseCrashlyticsService {
  static final String tag =
      {AppCore.tag, "FirebaseCrashlyticsService"}.join("_");

  void init();

  Future<void> disableCollectionEnabledOnDebugMode();

  Future<void> recordError(
    Object exception,
    StackTrace? stackTrace, {
    bool fatal = true,
  });

  FutureOr<dynamic> callBackWrapper(
    FutureOr<dynamic> function,
  );
}
