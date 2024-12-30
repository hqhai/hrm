import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/data/source/api/client/base/dio_builder.dart';
import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/middleware/access_token_interceptor.dart';
import 'package:base_app/data/source/api/middleware/header_interceptor.dart';
import 'package:base_app/data/source/api/middleware/refresh_token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class RequestUrlApiClient extends RestApiClient {
  RequestUrlApiClient(
    HeaderInterceptor headerInterceptor,
    AccessTokenInterceptor accessTokenInterceptor,
    RefreshTokenInterceptor refreshTokenInterceptor,
  ) : super(
          dio: DioBuilder.createDio(
            options: BaseOptions(
              baseUrl: AppConfig.instance.baseRequestUrl,
            ),
            interceptors: [
              headerInterceptor,
              accessTokenInterceptor,
              refreshTokenInterceptor,
            ],
          ),
        );
}
