import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/services/requisition.service.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: RequisitionService)
class RequisitionServiceImpl extends BaseService implements RequisitionService {
  late String baseUrl;
  late String baseURLFile;
  late String baseUrlUser;

  RequisitionServiceImpl() : super() {
    baseUrl = appConfig.baseRequestUrl;
    baseURLFile = appConfig.baseURLFile;
    baseUrlUser = appConfig.baseUserUrl;
  }

  @override
  Future<List<Flow>> getFlowByUser() async {
    final url = '$baseUrlUser${PathConfig.getFlowByUser}';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result['item'];
    List<Flow> flows = (data as List<dynamic>).map((e) => Flow.fromJson(e as Map<String, dynamic>)).toList();
    return flows;
  }

  @override
  Future<int> postRequest({required PostRequestRequest postRequestRequest}) async {
    final url = '$baseUrl${PathConfig.request}';
    final body = jsonEncode(postRequestRequest.toJson());
    final response = await client.post(url, body:  body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final statusCode = responseBase.statusCode;
    return statusCode;
  }

  @override
  Future<int> approveRequisition({required String id, String? note, required String status}) {
    // TODO: implement approveRequisition
    throw UnimplementedError();
  }

  @override
  Future<Request> getRequisitionById({required String id}) {
    // TODO: implement getRequisitionById
    throw UnimplementedError();
  }

  @override
  Future<List<Request>> getRequisitions({int? page}) {
    // TODO: implement getRequisitions
    throw UnimplementedError();
  }

  @override
  Future<List<Request>> getRequisitionsApprove({int? page}) {
    // TODO: implement getRequisitionsApprove
    throw UnimplementedError();
  }

  @override
  Future<List<Request>> getRequisitionsApproveByFilter({int? page, RequisitionTypeEnum? type, String? departmentId, String? startDate, String? endDate, List<StatusRequestEnum>? status}) {
    // TODO: implement getRequisitionsApproveByFilter
    throw UnimplementedError();
  }

  @override
  Future<List<Request>> getRequisitionsByFilter({int? page, RequisitionTypeEnum? type, String? departmentId, String? startDate, String? endDate, List<StatusRequestEnum>? status}) {
    // TODO: implement getRequisitionsByFilter
    throw UnimplementedError();
  }



}
