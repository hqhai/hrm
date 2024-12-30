import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/configs/app_configs.dart';
import '../middleware/header_interceptor.dart';
import 'base/dio_builder.dart';
import 'base/rest_client_base.dart';

@LazySingleton()
class NoneAuthAppServerApiClient extends RestApiClient {
  NoneAuthAppServerApiClient(HeaderInterceptor headerInterceptor)
      : super(
    dio: DioBuilder.createDio(
      options: BaseOptions(baseUrl: AppConfig.instance.baseUrl),
      interceptors: [
        headerInterceptor,
      ],
    ),
  );
}
