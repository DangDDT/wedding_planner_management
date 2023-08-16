import 'package:isar/isar.dart';

import '../environment.dart';
import 'core.dart';

class AppCore {
  static const String tag = 'WPM';

  final Environment environment;

  AppCore({
    required this.environment,
  });

  Future<void> init() async {
    /// Initialize Isar
    await Isar.initializeIsarCore();

    /// Set up locator
    GlobalBinding.setUpLocator(environment: environment);

    /// Initialize ModuleManager
    await ModuleManager.initializeModules();
  }
}
