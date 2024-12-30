import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_error.freezed.dart';

@freezed
class ServerError with _$ServerError {
  const ServerError._();
  const factory ServerError({
    /// server-defined status code
    int? statusCode,
    @Default(ServerError.defaultErrors) List<String> errors,
  }) = _ServerError;

  static const defaultGeneralServerStatusCode = -1;
  static const defaultGeneralServerErrorId = '';
  static const defaultGeneralMessage = '';
  static const defaultErrors = <String>[];

  @override
  String toString() {
    return 'ServerError(errors: [${errors.map((error) => error.toString()).join(', ')}])';
  }
}
