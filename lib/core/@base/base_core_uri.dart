import '../core.dart';

abstract class BaseCoreUri extends CoreUriConfig {
  BaseCoreUri({
    required super.environment,
  });

  String getUrlValue(String key) {
    final url = eval[key];
    if (url == null) {
      throw Exception(
        'Api with key $key map to environment: ${environment.name} does not exist.',
      );
    }
    return url;
  }
}
