import 'dart:async';
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

import 'base/base_interceptor.dart';

@Injectable()
class RefreshTokenInterceptor extends BaseInterceptor {
  RefreshTokenInterceptor(this.appPreferences, this.refreshTokenApiService,
      this._noneAuthAppServerApiClient);

  final AppPreferences appPreferences;
  final RefreshTokenApiService refreshTokenApiService;
  final NoneAuthAppServerApiClient _noneAuthAppServerApiClient;

  Completer<String>? _refreshCompleter;
  final _queue = Queue<_QueuedRequest>();

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
    _queue.addLast(_QueuedRequest(options, handler));

    if (_refreshCompleter != null) {
      // Another refresh is already in progress, wait for it
      try {
        final newToken = await _refreshCompleter!.future;
        await _retryQueuedRequest(_queue.removeLast(), newToken);
      } catch (e) {
        _handleQueuedRequestError(_queue.removeLast(), e);
      }
      return;
    }

    _refreshCompleter = Completer<String>();
    try {
      final newToken = await _refreshToken();
      _refreshCompleter!.complete(newToken);
      await _onRefreshTokenSuccess(newToken);
    } catch (e) {
      _refreshCompleter!.completeError(e);
      _onRefreshTokenError(e);
    } finally {
      _refreshCompleter = null;
      _queue.clear();
    }
  }

  Future<String> _refreshToken() async {
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
    final requests = _queue.toList();
    await Future.wait(requests.map(
      (requestInfo) => _retryQueuedRequest(requestInfo, newToken),
    ));
  }

  Future<void> _retryQueuedRequest(_QueuedRequest request, String newToken) async {
    _putAccessToken(headers: request.options.headers, accessToken: newToken);
    try {
      final response = await _noneAuthAppServerApiClient.dio.fetch(request.options);
      request.handler.resolve(response);
    } catch (e) {
      request.handler.next(DioException(requestOptions: request.options, error: e));
    }
  }

  void _handleQueuedRequestError(_QueuedRequest request, Object error) {
    request.handler.next(DioException(requestOptions: request.options, error: error));
  }

  void _onRefreshTokenError(Object? error) {
    for (var element in _queue) {
      element.handler.next(DioException(requestOptions: element.options, error: error));
    }
    dI<AuthBloc>().add(const LogoutEvent());
    appPreferences.saveAccessToken('');
    appPreferences.saveRefreshToken('');
  }
}

class _QueuedRequest {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;

  _QueuedRequest(this.options, this.handler);
}
