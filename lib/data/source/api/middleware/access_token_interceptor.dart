import 'package:base_app/data/source/api/middleware/base/base_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/constants/server_request_response_containts.dart';
import '../../preference/preference.dart';

@Injectable()
class AccessTokenInterceptor extends BaseInterceptor {
  AccessTokenInterceptor(this._appPreferences);

  final AppPreferences _appPreferences;

  @override
  int get priority => BaseInterceptor.accessTokenPriority;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = _appPreferences.accessToken;

    if (token != null && token.isNotEmpty) {
      options.headers[ServerRequestResponseConstants.basicAuthorization] =
          '${ServerRequestResponseConstants.bearer} $token';
    }

    handler.next(options);
  }
}
