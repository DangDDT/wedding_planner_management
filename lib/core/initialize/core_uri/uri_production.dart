part of 'core_uri.dart';

class UriProduction extends BaseCoreUri {
  UriProduction()
      : super(
          environment: Environment.prod,
        );

  @override
  // TODO: implement _appBaseUrl
  String get _appBaseUrl => throw UnimplementedError();
}
