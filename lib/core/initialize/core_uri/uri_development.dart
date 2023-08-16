part of 'core_uri.dart';

class UriDevelopment extends BaseCoreUri {
  UriDevelopment()
      : super(
          environment: Environment.dev,
        );

  @override
  String get _appBaseUrl =>
      'https://api-demo.vietinfo.tech/BinhThanh/Dashboard';
}
