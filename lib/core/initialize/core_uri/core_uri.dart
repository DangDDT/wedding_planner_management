import '../../../environment.dart';
import '../../core.dart';

part 'uri_development.dart';
part 'uri_production.dart';
part 'uri_staging.dart';

///Guide
///1. Create key & value for api endpoint
///2. Create value for each environment [dev, staging, prod]
///3. Create variable in CoreUri to use in app.

abstract class CoreUriConfig {
  final Environment environment;

  CoreUriConfig({
    required this.environment,
  });

  static String appBaseUrl = 'app_base_url';
  String get _appBaseUrl;

  Map<String, String> get eval => {
        appBaseUrl: _appBaseUrl,
      };
}

class CoreUri {
  static final String tag = {AppCore.tag, 'CoreUri'}.join('_');

  final Environment environment;

  late BaseCoreUri _coreUri;

  CoreUri({
    required this.environment,
  }) {
    switch (environment) {
      case Environment.dev:
        _coreUri = UriDevelopment();
        break;
      case Environment.staging:
        _coreUri = UriStaging();
        break;
      case Environment.prod:
        _coreUri = UriProduction();
        break;
      default:
        _coreUri = UriDevelopment();
    }
  }

  String get appBaseUrl => _coreUri.getUrlValue(
        CoreUriConfig.appBaseUrl,
      );

  Map<String, String> get eval => _coreUri.eval;
}
