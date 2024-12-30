import 'dart:convert';

import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/check_in_setting/create_check_in_setting_request.dart';
import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/mapper/base_success_response_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../../models/base/data_response.dart';
import '../client/system_api_client.dart';

@LazySingleton()
class CheckInSettingService {
  CheckInSettingService(this._systemClient) : super();

  final SystemApiClient _systemClient;

  Future<DataResponse?> createCheckInSetting(
      {required CreateCheckInSettingRequest
          createCheckInSettingRequest}) async {
    return _systemClient.request(
      method: RestMethod.post,
      path: PathConfig.checkInSetting,
      body: jsonEncode(createCheckInSettingRequest.toJson()),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }
}
