import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/services/user.service.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: UserService)
class UserServiceImpl extends BaseService implements UserService {
  late String baseUrl;

  UserServiceImpl() : super() {
    baseUrl = appConfig.baseApiUrl;
  }
  @override
  getUserInfo() async {
    final url = '$baseUrl${PathConfig.userInfo}';
    final response = await client.post(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    return responseBase;
  }
}
