import 'dart:convert';

import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/base/data_response.dart';
import 'package:base_app/data/models/personnel/create_personnel_request.dart';
import 'package:base_app/data/source/api/client/auth_api_client.dart';
import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/mapper/base_success_response_mapper.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class PersonnelService {
  final AuthApiClient _authApiClient;

  PersonnelService(this._authApiClient);

  Future<DataResponse?> createPersonnel({required CreatePersonnelRequest createPersonnelRequest}) async {
    return _authApiClient.request(
      method: RestMethod.post,
      path: PathConfig.signup,
      body: jsonEncode(createPersonnelRequest.toJson()),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }
}
