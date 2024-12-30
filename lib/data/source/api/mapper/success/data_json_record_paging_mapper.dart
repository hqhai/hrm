import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/mapper/base_success_response_mapper.dart';

import '../../../../models/base/data_response.dart';

class DataJsonRecordPagingMapper<T extends Object> extends BaseSuccessResponseMapper<T, DataListRecordPagingResponse<T>> {
  @override
  DataListRecordPagingResponse<T>? mapToDataModel({required response, Decoder<T>? decoder}) {
    return decoder != null && response is Map<String, dynamic>
        ? DataListRecordPagingResponse.fromJson(
            response,
            (json) => decoder(json),
          )
        : null;
  }
}
