// ignore_for_file: depend_on_referenced_packages

import 'package:retrofit/retrofit.dart';

import '../../../core/core.dart';

// part 'base_api_client.g.dart';

@RestApi()
abstract class BaseApiClient {
  static final String tag = {AppCore.tag, "ApiClient"}.join("_");

  // factory BaseApiClient(Dio dio, {String baseUrl}) = _BaseApiClient;
}
