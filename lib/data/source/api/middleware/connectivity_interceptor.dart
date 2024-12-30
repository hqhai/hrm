import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'base/base_interceptor.dart';

@Injectable()
class ConnectivityInterceptor extends BaseInterceptor {
  @override
  int get priority => BaseInterceptor.connectivityPriority;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.first == ConnectivityResult.none) {
      return handler.reject(
        DioException(
          requestOptions: options,
        ),
      );
    }

    return super.onRequest(options, handler);
  }
}
