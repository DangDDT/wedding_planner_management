import 'package:get/get.dart';

import '../../src/domain/services/isar/isar_service.dart';
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

  final IsarService _isarService = Get.find<IsarService>(tag: IsarService.tag);
}

class AppState {}
