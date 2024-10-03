import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/flow/flow_by_id_request.dart';
import 'package:base_app/data/models/requisition/flow/flow_response.dart';
import 'package:base_app/data/models/requisition/requisition/get_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request/get_requests_by_ids.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/approve_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/cancel_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/get_request_approve_filter_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/get_request_filter_request.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_request.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_response.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/data/models/response/approve_requisition_count_status_response.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/services/requisition.service.dart';
import 'package:flutter/foundation.dart';
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
  Future<FlowResponse> getFlowByUser({required GetRequestRequest getRequestRequest}) async {
    final url = '$baseUrl${PathConfig.getFlowByUser}';
    getRequestRequest = getRequestRequest.copyWith(pageSize: RequisitionTypeEnum.values.length);
    final params = getRequestRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final result = responseBase.result;
    final FlowResponse flowResponse = FlowResponse.fromJson(result);
    return flowResponse;
  }

  @override
  Future<Request> postRequest({required PostRequestRequest postRequestRequest}) async {
    final url = '$baseUrl${PathConfig.request}';
    final body = jsonEncode(postRequestRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final result = responseBase.result;
    final Request request = Request.fromJson(result);
    return request;
  }

  @override
  Future<Request> getRequisitionById({required String id}) async {
    final url = '$baseUrl${PathConfig.requestInId}/$id';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final Request request = Request.fromJson(data);
    return request;
  }

  @override
  Future<RequestsResponse> getRequisitionsSelfByFilter(
      {required GetRequestFilterRequest getRequestFilterRequest}) async {
    final url = '$baseUrl${PathConfig.getRequestSelf}';
    final params = getRequestFilterRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final RequestsResponse requestsResponse = RequestsResponse.fromJson(data);
    return requestsResponse;
  }

  @override
  Future<RequestsResponse> getRequisitionsApproveByFilter(
      {required GetRequestApproveFilterRequest getRequestApproveFilterRequest}) async {
    final url = '$baseUrl${PathConfig.getRequestApprove}';
    final params = getRequestApproveFilterRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final RequestsResponse requestsResponse = RequestsResponse.fromJson(data);
    return requestsResponse;
  }

  @override
  Future<RequestsResponse> getRequisitionsFollowerByFilter(
      {required GetRequestFilterRequest getRequestFilterRequest}) async {
    final url = '$baseUrl${PathConfig.getRequestFollower}';
    final params = getRequestFilterRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final RequestsResponse requestsResponse = RequestsResponse.fromJson(data);
    return requestsResponse;
  }

  @override
  Future<SearchStationeryByNameResponse> getStationery(
      {required SearchStationeryByNameRequest searchStationeryByNameRequest}) async {
    final url = '$baseUrl${PathConfig.stationery}';
    final params = searchStationeryByNameRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final SearchStationeryByNameResponse searchStationeryByNameResponse =
        SearchStationeryByNameResponse.fromJson(data);
    return searchStationeryByNameResponse;
  }

  @override
  Future<FlowRequest> getFlowById({required FlowByIdRequest flowByIdRequest}) async {
    final url = '$baseUrl${PathConfig.flow}/${flowByIdRequest.id}';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final FlowRequest flow = FlowRequest.fromJson(data);
    return flow;
  }

  @override
  Future<bool> approveRequisition({required ApproveRequest approveRequest}) async {
    final url = '$baseUrl${PathConfig.stepRequestApprover}';
    final body = jsonEncode(approveRequest.toJson());
    final response = await client.put(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final bool data = responseBase.result;
    return data;
  }

  @override
  Future<ApproveRequisitionCountStatusResponse> approveRequisitionCountStatus(
      {required GetRequestApproveFilterRequest getRequestApproveFilterRequest}) async {
    try {
      final url = '$baseUrl${PathConfig.stepRequestApproverCountStatus}';
      final params = getRequestApproveFilterRequest.toJson();
      final response = await client.get(url, params: params);
      final responseBase = ResponseBase.fromJson(json.decode(response.body));
      final ApproveRequisitionCountStatusResponse data =
          ApproveRequisitionCountStatusResponse.fromJson(responseBase.result);
      return data;
    } catch (ex) {
      debugPrint('🔎 : $ex ❗️');
      rethrow;
    }
  }

  @override
  Future<bool> userRejectRequisitionById({required String id}) async {
    final url = '$baseUrl${PathConfig.changeStatus}/$id';
    final response = await client.put(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final result = responseBase.result;
    return result;
  }

  @override
  Future<Request> editRequestEdit({required PostRequestRequest postRequestRequest}) async {
    final url = '$baseUrl${PathConfig.editRequestEdit}';
    final body = jsonEncode(postRequestRequest.toJson());
    final response = await client.put(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final Request request = Request.fromJson(data);
    return request;
  }

  @override
  Future<RequestsResponse> getRequestsByIds({required GetRequestsByIds getRequestsByIds}) async {
    final url = '$baseUrl${PathConfig.requestByIds}';
    final body = jsonEncode(getRequestsByIds.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final requests =
        (data as List<dynamic>).map((e) => Request.fromJson(e as Map<String, dynamic>)).toList();
    final requestsResponse = RequestsResponse(items: requests);
    return requestsResponse;
  }

  @override
  Future<void> cancelRequestsById({required CancelRequest cancelRequest}) async {
    try {
      final url = '$baseUrl${PathConfig.cancelRequest}';
      final body = jsonEncode(cancelRequest.toJson());
      await client.put(url, body: body);
    } catch (ex) {
      debugPrint('🔎 : $ex ❗️');
      rethrow;
    }
  }

  @override
  Future<ApproveRequisitionCountStatusResponse> userRequisitionCountStatus(
      {required GetRequestFilterRequest getRequestFilterRequest}) async {
    try {
      final url = '$baseUrl${PathConfig.stepRequestUserCountStatus}';
      final params = getRequestFilterRequest.toJson();
      final response = await client.get(url, params: params);
      final responseBase = ResponseBase.fromJson(json.decode(response.body));
      final ApproveRequisitionCountStatusResponse data =
          ApproveRequisitionCountStatusResponse.fromJson(responseBase.result);
      return data;
    } catch (ex) {
      debugPrint('🔎 : $ex ❗️');
      rethrow;
    }
  }
}
