import '../../../../models/base/data_response.dart';
import '../../client/base/rest_client_base.dart';
import '../base_success_response_mapper.dart';

class DataJsonArrayResponseMapper<T extends Object>
    extends BaseSuccessResponseMapper<T, DataListResponse<T>> {
  @override
  DataListResponse<T>? mapToDataModel({
    required dynamic response,
    Decoder<T>? decoder,
  }) {
    return decoder != null && response is Map<String, dynamic>
        ? DataListResponse.fromJson(response, (json) => decoder(json))
        : null;
  }
}
