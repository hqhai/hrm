import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../mapper/base_error_reponse_mapper.dart';
import '../../mapper/base_success_response_mapper.dart';
import '../../middleware/connectivity_interceptor.dart';
import '../../middleware/custom_log_interceptor.dart';

class ApiClientDefaultSetting {
  const ApiClientDefaultSetting._();

  static const defaultErrorResponseMapperType =
      ErrorResponseMapperType.jsonArrayObject;
  static const defaultSuccessResponseMapperType =
      SuccessResponseMapperType.dataJsonObject;

  static List<Interceptor> requiredInterceptors(Dio dio) => [
        if (kDebugMode) CustomLogInterceptor(),
        ConnectivityInterceptor(),
      ];
}
