import 'package:base_app/data/source/api/client/base/rest_client_base.dart';

import '../../../../models/base/data_response.dart';
import '../base_success_response_mapper.dart';

class DataJsonObjectResponseMapper<T extends Object>
    extends BaseSuccessResponseMapper<T, DataResponse<T>> {
  @override
  DataResponse<T>? mapToDataModel({
    required dynamic response,
    Decoder<T>? decoder,
  }) {
    return decoder != null && response is Map<String, dynamic>
        ? DataResponse.fromJson(response, (json) => decoder(json))
        : null;
  }
}
