import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/base/data_response.dart';
import 'package:base_app/data/models/requisition/flow/flow_by_id_request.dart';
import 'package:base_app/data/models/requisition/flow/flow_response.dart';
import 'package:base_app/data/models/requisition/requisition/get_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request/get_requests_by_ids.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/approve_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/approves_step_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/cancel_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/get_request_approve_filter_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/get_request_filter_request.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_request.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_response.dart';
import 'package:base_app/data/models/response/approve_requisition_count_status_response.dart';
import 'package:base_app/data/source/api/client/base/rest_client_base.dart';
import 'package:base_app/data/source/api/client/request_api_client.dart';
import 'package:base_app/data/source/api/mapper/base_success_response_mapper.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class RequisitionService {
  final RequestApiClient _requestUrlApiClient;

  RequisitionService(
    this._requestUrlApiClient,
  );

  Future<DataResponse<FlowResponse>?> getFlowByUser({
    required GetRequestRequest getRequestRequest,
  }) async {
    return _requestUrlApiClient.request(
      method: RestMethod.get,
      path: PathConfig.getFlowByUser,
      queryParameters: getRequestRequest.toJson(),
      decoder: (json) => FlowResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<Request>?> postRequest(
      {required PostRequestRequest postRequestRequest}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.post,
      path: PathConfig.request,
      body: postRequestRequest.toJson(),
      decoder: (json) => Request.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<Request>?> getRequisitionById(
      {required String id}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.get,
      path: '${PathConfig.requestInId}/$id',
      // queryParameters: {'id': id},
      decoder: (json) => Request.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<RequestsResponse>?> getRequisitionsSelfByFilter(
      {required GetRequestFilterRequest getRequestFilterRequest}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.get,
      path: PathConfig.getRequestSelf,
      queryParameters: getRequestFilterRequest.toJson(),
      decoder: (json) =>
          RequestsResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<RequestsResponse>?> getRequisitionsApproveByFilter(
      {required GetRequestApproveFilterRequest
          getRequestApproveFilterRequest}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.get,
      path: PathConfig.getRequestApprove,
      queryParameters: getRequestApproveFilterRequest.toJson(),
      decoder: (json) =>
          RequestsResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<RequestsResponse>?> getRequisitionsFollowerByFilter({
    required GetRequestFilterRequest getRequestFilterRequest,
  }) async {
    return _requestUrlApiClient.request(
      method: RestMethod.get,
      path: PathConfig.getRequestFollower,
      queryParameters: getRequestFilterRequest.toJson(),
      decoder: (json) =>
          RequestsResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<SearchStationeryByNameResponse>?> getStationery({
    required SearchStationeryByNameRequest searchStationeryByNameRequest,
  }) async {
    return _requestUrlApiClient.request(
      method: RestMethod.get,
      path: PathConfig.stationery,
      queryParameters: searchStationeryByNameRequest.toJson(),
      decoder: (json) =>
          SearchStationeryByNameResponse.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<FlowRequest>?> getFlowById(
      {required FlowByIdRequest flowByIdRequest}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.get,
      path: '${PathConfig.flow}/${flowByIdRequest.id}',
      decoder: (json) => FlowRequest.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<bool>?> approveRequisition(
      {required ApproveRequest approveRequest}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.put,
      path: PathConfig.stepRequestApprover,
      body: approveRequest.toJson(),
      decoder: (json) => json as bool,
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<ApproveRequisitionCountStatusResponse>?>
      approveRequisitionCountStatus({
    required GetRequestApproveFilterRequest getRequestApproveFilterRequest,
  }) async {
    return _requestUrlApiClient.request(
      method: RestMethod.get,
      path: PathConfig.stepRequestApproverCountStatus,
      queryParameters: getRequestApproveFilterRequest.toJson(),
      decoder: (json) => ApproveRequisitionCountStatusResponse.fromJson(
          json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<bool>?> userRejectRequisitionById(
      {required String id}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.put,
      path: '${PathConfig.changeStatus}/$id',
      decoder: (json) => json as bool,
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<Request>?> editRequestEdit(
      {required PostRequestRequest postRequestRequest}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.put,
      path: PathConfig.editRequestEdit,
      body: postRequestRequest.toJson(),
      decoder: (json) => Request.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataListResponse<Request>?> getRequestsByIds(
      {required GetRequestsByIds getRequestsByIds}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.post,
      path: PathConfig.requestByIds,
      body: getRequestsByIds.toJson(),
      decoder: (json) =>
          Request.fromJson(json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    );
  }

  Future<DataResponse<void>?> cancelRequestsById(
      {required CancelRequest cancelRequest}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.put,
      path: PathConfig.cancelRequest,
      body: cancelRequest.toJson(),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<ApproveRequisitionCountStatusResponse>?>
      userRequisitionCountStatus({
    required GetRequestFilterRequest getRequestFilterRequest,
  }) async {
    return _requestUrlApiClient.request(
      method: RestMethod.get,
      path: PathConfig.stepRequestUserCountStatus,
      body: getRequestFilterRequest.toJson(),
      decoder: (json) => ApproveRequisitionCountStatusResponse.fromJson(
          json as Map<String, dynamic>),
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }

  Future<DataResponse<bool>?> approveRequisitions(
      {required ApprovesStepRequest approvesStepRequest}) async {
    return _requestUrlApiClient.request(
      method: RestMethod.put,
      path: PathConfig.stepRequestApprovers,
      body: approvesStepRequest.toJson(),
      decoder: (json) => json as bool,
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
    );
  }
}
