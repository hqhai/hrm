import 'package:base_app/common/exception/remote/server_error.dart';
import 'package:base_app/data/source/api/mapper/base_error_reponse_mapper.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class JsonArrayErrorResponseMapper
    extends BaseErrorResponseMapper<Map<String, dynamic>> {
  @override
  ServerError mapToServerError(Map<String, dynamic>? errorResponse) {
    if (errorResponse == null) {
      return const ServerError(
        statusCode: null,
        errors: [],
      );
    }

    // Extract the statusCode and errorMessages from the response
    int? statusCode = errorResponse['statusCode'] as int?;
    List<dynamic>? errorMessages =
        errorResponse['errorMessages'] as List<dynamic>?;

    // Map the errorMessages to ServerErrorDetail objects
    List<String> serverErrorCodeDetails =
        errorMessages?.map((e) => e['errorCode'] as String).toList() ?? [];

    return ServerError(
      statusCode: statusCode,
      errors: serverErrorCodeDetails,
    );
  }
}
