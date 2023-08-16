part of 'core_uri.dart';

class UriStaging extends BaseCoreUri {
  UriStaging()
      : super(
          environment: Environment.staging,
        );

  @override
  // TODO: implement _appBaseUrl
  String get _appBaseUrl => throw UnimplementedError();
}
