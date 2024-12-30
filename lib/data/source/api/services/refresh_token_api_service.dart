
import 'package:base_app/common/exception/remote/remote_exception.dart';
import 'package:base_app/data/models/base/data_response.dart';
import 'package:base_app/data/models/response/login_response.dart';
import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/client/refresh_token_api_client.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class RefreshTokenApiService {
  RefreshTokenApiService(this._refreshTokenApiClient);

  final RefreshTokenApiClient _refreshTokenApiClient;

  Future<DataResponse<LoginResponse>?> refreshToken(String refreshToken, String accessToken) async {
    try {
      final DataResponse<LoginResponse>? response = await _refreshTokenApiClient.request(
        method: RestMethod.post,
        path: '/auth/refresh-token',
        body: {
          "refreshToken": refreshToken,
          "accessToken": accessToken,
        },
        decoder: (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
      );

      return response;
    } catch (e) {
      if (e is RemoteException && (e.kind == RemoteExceptionKind.serverDefined || e.kind == RemoteExceptionKind.serverUndefined)) {
        throw RemoteException(
          kind: RemoteExceptionKind.refreshTokenFailed,
          serverError: e.serverError,
          httpErrorCode: e.httpErrorCode,
          rootException: e.rootException,
        );
      }
      rethrow;
    }
  }
}
