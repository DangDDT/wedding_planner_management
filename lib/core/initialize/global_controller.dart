import 'package:get/get.dart';

import '../core.dart';

class AppController extends GetxController {
  static final String tag = {AppCore.tag, 'AppController'}.join('_');

  late final AppState _appState;
  AppState get appState => _appState;

  @override
  void onInit() {
    _appState = AppState();
    super.onInit();
  }
}

class AppState {}
