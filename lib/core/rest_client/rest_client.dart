
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:checkplay_mobile/core/constants/constants.dart';
import 'package:checkplay_mobile/core/constants/enviroments.dart';
import 'package:checkplay_mobile/core/rest_client/interceptors/auth_interceptor.dart';

class RestClient extends DioForNative {
  RestClient()
      : super(BaseOptions(
          baseUrl: Enviroments.param(Constants.ENV_BASE_URL_KEY) ?? '',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 60),
        )) {
    interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
      AuthInterceptor(),
    ]);
  }

  RestClient get auth {
    options.extra[Constants.ENV_AUTH_REQUIRED] = true;
    return this;
  }

  RestClient get unAuth {
    options.extra[Constants.ENV_AUTH_REQUIRED] = false;
    return this;
  }
}
