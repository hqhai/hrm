import 'dart:convert';

import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/requisition/flow/flow_by_id_request.dart';
import 'package:base_app/data/models/requisition/flow/flow_response.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/requisition/get_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/approve_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/get_request_approve_filter_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/get_request_filter_request.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_request.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_response.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/entities/reqisition/stationery/stationery.dart';
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
  Future<FlowResponse> getFlowByUser({required GetRequestRequest getRequestRequest}) async {
    final url = '$baseUrl${PathConfig.getFlowByUser}';
    final params = getRequestRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final items = responseBase.result['items'];
    final totalItems = responseBase.result['pagingInfo']['totalItems'];
    List<FlowRequest> flows = (items as List<dynamic>)
        .map((e) => FlowRequest.fromJson(e as Map<String, dynamic>))
        .toList();
    int total = totalItems;
    return FlowResponse(flows: flows, totalItems: total);
  }

  @override
  Future<int> postRequest({required PostRequestRequest postRequestRequest}) async {
    final url = '$baseUrl${PathConfig.request}';
    final body = jsonEncode(postRequestRequest.toJson());
    final response = await client.post(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final statusCode = responseBase.statusCode;
    return statusCode;
  }

  @override
  Future<Request> getRequisitionById({required String id}) async {
    final url = '$baseUrl${PathConfig.requestInId}/$id';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    Request request = Request.fromJson(data);
    return request;
  }

  @override
  Future<RequestsResponse> getRequisitions({required GetRequestRequest requestsRequest}) async {
    final url = '$baseUrl${PathConfig.getRequestSelf}';
    final params = requestsRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result['items'];
    final totalItems = responseBase.result['pagingInfo']['totalItems'];
    List<Request> request =
        (data as List<dynamic>).map((e) => Request.fromJson(e as Map<String, dynamic>)).toList();
    return RequestsResponse(totalItems: totalItems, requests: request);
  }

  @override
  Future<RequestsResponse> getRequisitionsApprove(
      {required GetRequestRequest requestsRequest}) async {
    final url = '$baseUrl${PathConfig.getRequestApprove}';
    final params = requestsRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result['items'];
    final totalItems = responseBase.result['pagingInfo']['totalItems'];
    List<Request> request =
        (data as List<dynamic>).map((e) => Request.fromJson(e as Map<String, dynamic>)).toList();
    return RequestsResponse(totalItems: totalItems, requests: request);
  }

  @override
  Future<RequestsResponse> getRequisitionsByFilter(
      {required GetRequestFilterRequest getRequestFilterRequest}) async {
    final url = '$baseUrl${PathConfig.getRequestSelf}';
    final params = getRequestFilterRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result['items'];
    final totalItems = responseBase.result['pagingInfo']['totalItems'];
    List<Request> request =
        (data as List<dynamic>).map((e) => Request.fromJson(e as Map<String, dynamic>)).toList();
    return RequestsResponse(totalItems: totalItems, requests: request);
  }

  @override
  Future<RequestsResponse> getRequisitionsApproveByFilter(
      {required GetRequestApproveFilterRequest getRequestApproveFilterRequest}) async {
    final url = '$baseUrl${PathConfig.getRequestApprove}';
    final params = getRequestApproveFilterRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result['items'];
    final totalItems = responseBase.result['pagingInfo']['totalItems'];
    List<Request> request =
        (data as List<dynamic>).map((e) => Request.fromJson(e as Map<String, dynamic>)).toList();
    return RequestsResponse(totalItems: totalItems, requests: request);
  }

  @override
  Future<SearchStationeryByNameResponse> getStationery(
      {required SearchStationeryByNameRequest searchStationeryByNameRequest}) async {
    final url = '$baseUrl${PathConfig.stationery}';
    final params = searchStationeryByNameRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result['items'];
    final totalItems = responseBase.result['pagingInfo']['totalItems'];
    List<Stationery> stationeries =
        (data as List<dynamic>).map((e) => Stationery.fromJson(e as Map<String, dynamic>)).toList();
    return SearchStationeryByNameResponse(totalItems: totalItems, stationery: stationeries);
  }

  @override
  Future<FlowRequest> getFlowById({required FlowByIdRequest flowByIdRequest}) async {
    final url = '$baseUrl${PathConfig.flow}/${flowByIdRequest.id}';
    final response = await client.get(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    FlowRequest flow = FlowRequest.fromJson(data);
    return flow;
  }

  @override
  Future<RequestsResponse> getRequisitionsFollowerByFilter(
      {required GetRequestFilterRequest getRequestFilterRequest}) async {
    final url = '$baseUrl${PathConfig.getRequestFollower}';
    final params = getRequestFilterRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result['items'];
    final totalItems = responseBase.result['pagingInfo']['totalItems'];
    List<Request> request =
        (data as List<dynamic>).map((e) => Request.fromJson(e as Map<String, dynamic>)).toList();
    return RequestsResponse(totalItems: totalItems, requests: request);
  }

  @override
  Future<String> approveRequisition({required ApproveRequest approveRequest}) async {
    final url = '$baseUrl${PathConfig.stepRequestApprover}';
    final body = jsonEncode(approveRequest.toJson());
    final response = await client.put(url, body: body);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.statusCode;
    return data.toString();
  }

  @override
  Future<int> userRejectRequisitionById({required String id}) async {
    final url = '$baseUrl${PathConfig.changeStatus}/$id';
    final response = await client.put(url);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final statusCode = responseBase.statusCode;
    return statusCode;
  }
}
