import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import '../../../../common/configs/app_configs.dart';
import '../middleware/access_token_interceptor.dart';
import '../middleware/header_interceptor.dart';
import '../middleware/refresh_token_interceptor.dart';
import 'base/dio_builder.dart';
import 'base/rest_client_base.dart';

@LazySingleton()
class AuthApiClient extends RestApiClient {
  AuthApiClient(
      HeaderInterceptor headerInterceptor,
      AccessTokenInterceptor accessTokenInterceptor,
      RefreshTokenInterceptor refreshTokenInterceptor,
      ) : super(
    dio: DioBuilder.createDio(
      options: BaseOptions(
        baseUrl: AppConfig.instance.baseAuthUrl,
      ),
      interceptors: [
        headerInterceptor,
        accessTokenInterceptor,
        refreshTokenInterceptor,
      ],
    ),
  );
}
