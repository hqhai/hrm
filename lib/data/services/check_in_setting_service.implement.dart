import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/check_in_setting/create_check_in_setting_request.dart';
import 'package:base_app/domain/services/check_in_setting.service.dart';
import 'package:common/model/response.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: CheckInSettingService)
class CheckInSettingServiceImpl extends BaseService implements CheckInSettingService {
  late String baseUrlSystem;

  CheckInSettingServiceImpl() : super() {
    baseUrlSystem = appConfig.baseSystemUrl;
  }

  @override
  Future<int> createCheckInSetting(
      {required CreateCheckInSettingRequest createCheckInSettingRequest}) async {
    final url = '$baseUrlSystem${PathConfig.checkInSetting}';
    final body = jsonEncode(createCheckInSettingRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final statusCode = responseBase.statusCode;
    return statusCode;
  }
}
