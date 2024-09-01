import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/personnel/create_personnel_request.dart';
import 'package:base_app/domain/services/personnel.service.dart';
import 'package:common/model/response.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: PersonnelService)
class PersonnelServiceImpl extends BaseService implements PersonnelService {
  late String baseUrl;
  late String baseUrlUser;

  PersonnelServiceImpl() : super() {
    baseUrl = appConfig.baseAuthUrl;
    baseUrlUser = appConfig.baseUserUrl;
  }

  @override
  Future<int> createPersonnel({required CreatePersonnelRequest createPersonnelRequest}) async {
    final url = '$baseUrl${PathConfig.signup}';
    final body = jsonEncode(createPersonnelRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final statusCode = responseBase.statusCode;
    return statusCode;
  }
}
