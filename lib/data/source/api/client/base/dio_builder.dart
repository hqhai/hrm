import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';

import '../../../../../common/constants/server_timout_constants.dart';
import '../../middleware/base/base_interceptor.dart';
import 'api_client_default_setting.dart';

class DioBuilder {
  const DioBuilder._();

  static Dio createDio({
    BaseOptions? options,
    List<Interceptor> interceptors = const [],
  }) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: options?.connectTimeout ?? ServerTimeoutConstants.connectTimeout,
        receiveTimeout: options?.receiveTimeout ?? ServerTimeoutConstants.receiveTimeout,
        sendTimeout: options?.sendTimeout ?? ServerTimeoutConstants.sendTimeout,
        baseUrl: options?.baseUrl ?? "",
      ),
    );

    final sortedInterceptors = [
      ...ApiClientDefaultSetting.requiredInterceptors(dio),
      ...interceptors,
    ].sortedByDescending((element) {
      return element is BaseInterceptor ? element.priority : -1;
    });

    dio.interceptors.addAll(sortedInterceptors);

    return dio;
  }
}