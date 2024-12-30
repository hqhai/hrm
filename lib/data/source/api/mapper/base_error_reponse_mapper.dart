import '../../../../common/exception/remote/remote_exception.dart';
import '../../../../common/exception/remote/server_error.dart';
import 'error/json_object_error_response_mapper.dart';

enum ErrorResponseMapperType {
  jsonArrayObject,
}

abstract class BaseErrorResponseMapper<T extends Object> {
  const BaseErrorResponseMapper();

  factory BaseErrorResponseMapper.fromType(ErrorResponseMapperType type) {
    switch (type) {
      case ErrorResponseMapperType.jsonArrayObject:
        return JsonArrayErrorResponseMapper() as BaseErrorResponseMapper<T>;
    }
  }

  ServerError map(dynamic errorResponse) {
    try {
      if (errorResponse is! T) {
        throw RemoteException(
          kind: RemoteExceptionKind.decodeError,
          rootException: 'Response $errorResponse is not $T',
        );
      }

      final serverError = mapToServerError(errorResponse);

      return serverError;
    } on RemoteException catch (_) {
      rethrow;
    } catch (e) {
      throw RemoteException(
          kind: RemoteExceptionKind.decodeError, rootException: e);
    }
  }

  ServerError mapToServerError(T? errorResponse);
}
