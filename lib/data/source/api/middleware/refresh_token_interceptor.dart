import 'dart:collection';
import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/constants/server_request_response_containts.dart';
import 'package:base_app/data/source/api/client/non_auth_api_client.dart';
import 'package:base_app/data/source/api/services/refresh_token_api_service.dart';
import 'package:base_app/data/source/preference/preference.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tuple/tuple.dart';

import 'base/base_interceptor.dart';

@Injectable()
class RefreshTokenInterceptor extends BaseInterceptor {
  RefreshTokenInterceptor(this.appPreferences, this.refreshTokenApiService,
      this._noneAuthAppServerApiClient);

  final AppPreferences appPreferences;
  final RefreshTokenApiService refreshTokenApiService;
  final NoneAuthAppServerApiClient _noneAuthAppServerApiClient;

  var _isRefreshing = false;
  final _queue = Queue<Tuple2<RequestOptions, ErrorInterceptorHandler>>();

  @override
  int get priority => BaseInterceptor.refreshTokenPriority;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      final options = err.response!.requestOptions;
      _onExpiredToken(options: options, handler: handler);
      return;
    } else {
      handler.next(err);
      return;
    }
  }

  void _putAccessToken({
    required Map<String, dynamic> headers,
    required String accessToken,
  }) {
    headers[ServerRequestResponseConstants.basicAuthorization] =
        '${ServerRequestResponseConstants.bearer} $accessToken';
  }

  Future<void> _onExpiredToken({
    required RequestOptions options,
    required ErrorInterceptorHandler handler,
  }) async {
    _queue.addLast(Tuple2(options, handler));
    if (!_isRefreshing) {
      _isRefreshing = true;
      try {
        final newToken = await _refreshToken();
        await _onRefreshTokenSuccess(newToken);
      } catch (e) {
        _onRefreshTokenError(e);
      } finally {
        _isRefreshing = false;
        _queue.clear();
      }
    }
  }

  Future<String> _refreshToken() async {
    _isRefreshing = true;
    final refreshToken = appPreferences.refreshToken;
    final accessToken = appPreferences.accessToken;
    final refreshTokenResponse = await refreshTokenApiService.refreshToken(
        refreshToken ?? "", accessToken ?? "");
    await Future.wait(
      [
        appPreferences.saveAccessToken(
          refreshTokenResponse?.data?.accessToken ?? '',
        ),
        appPreferences.saveRefreshToken(
          refreshTokenResponse?.data?.refreshToken ?? '',
        ),
      ],
    );

    return refreshTokenResponse?.data?.accessToken ?? '';
  }

  Future<void> _onRefreshTokenSuccess(String newToken) async {
    await Future.wait(_queue.map(
      (requestInfo) => _requestWithNewToken(
        options: requestInfo.item1,
        handler: requestInfo.item2,
        newAccessToken: newToken,
      ),
    ));
  }

  void _onRefreshTokenError(Object? error) {
    for (var element in _queue) {
      final options = element.item1;
      final handler = element.item2;
      handler.next(DioException(requestOptions: options, error: error));
    }
    // nên xu ly cho khac
    dI<AuthBloc>().add(const LogoutEvent());
    appPreferences.saveAccessToken('');
    appPreferences.saveRefreshToken('');
  }

  Future<void> _requestWithNewToken({
    required RequestOptions options,
    required ErrorInterceptorHandler handler,
    required String newAccessToken,
  }) async {
    _putAccessToken(headers: options.headers, accessToken: newAccessToken);
    try {
      final response = await _noneAuthAppServerApiClient.dio.fetch(options);
      handler.resolve(response);
    } catch (e) {
      handler.next(DioException(requestOptions: options, error: e));
    }
  }
}
