import 'package:base_app/common/enum/requisition_enum.dart';
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
import 'package:base_app/data/models/response/paging_infor_request.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/repositories/requisition.repository.dart';
import 'package:injectable/injectable.dart';

import '../source/api/services/requisition_service.dart';

@LazySingleton(as: RequisitionRepository)
class RequisitionRepositoryImplement extends RequisitionRepository {
  final RequisitionService _requestService;

  RequisitionRepositoryImplement(this._requestService);

  @override
  Future<FlowResponse?> getFlowByUser({required int page}) async {
    final response = await _requestService.getFlowByUser(
      getRequestRequest: GetRequestRequest(page: page),
    );
    final paging = response?.data?.pagingInfo;
    final items = response?.data?.items;
    return FlowResponse(
      pagingInfo: PagingInfoRequest(
        pageSize: paging?.pageSize ?? 0,
        totalItems: paging?.totalItems ?? 0,
        page: paging?.page ?? 0,
      ),
      items: items ?? [],
    );
  }

  @override
  Future<Request?> postRequest(
      {required PostRequestRequest postRequestRequest}) async {
    final response = await _requestService.postRequest(
      postRequestRequest: postRequestRequest,
    );
    return response?.data;
  }

  @override
  Future<bool?> approveRequisition(
      {required String id, String? note, required String status}) async {
    final response = await _requestService.approveRequisition(
        approveRequest:
            ApproveRequest(id: id, note: note ?? "", status: status));
    return response?.data;
  }

  @override
  Future<Request?> getRequisitionById({required String id}) async {
    final response = await _requestService.getRequisitionById(id: id);
    return response?.data;
  }

  @override
  Future<SearchStationeryByNameResponse?> getStationery(
      {required String name, required int page}) async {
    final response = await _requestService.getStationery(
        searchStationeryByNameRequest:
            SearchStationeryByNameRequest(page: page, product: name));
    return response?.data;
  }

  @override
  Future<FlowRequest?> getFlowById({required String id}) async {
    final response = await _requestService.getFlowById(
        flowByIdRequest: FlowByIdRequest(id: id));
    return response?.data;
  }

  @override
  Future<RequestsResponse?> getRequisitionsApproveByFilter(
      {int? page,
      List<RequisitionTypeEnum>? type,
      String? departmentId,
      String? userId,
      DateTime? startDate,
      DateTime? endDate,
      EnumStepRequestStatusEnum? status}) async {
    final response = await _requestService.getRequisitionsApproveByFilter(
      getRequestApproveFilterRequest: GetRequestApproveFilterRequest(
        createdCode: userId,
        startDate: startDate,
        endDate: endDate,
        statusApprove: status,
        page: page,
        createdDepartmentId: departmentId,
        types: type,
      ),
    );
    return response?.data;
  }

  @override
  Future<RequestsResponse?> getRequisitionsFollowerByFilter(
      {int? page,
      List<RequisitionTypeEnum>? type,
      String? departmentId,
      String? userId,
      DateTime? startDate,
      DateTime? endDate,
      StatusRequestEnum? status}) async {
    final response = await _requestService.getRequisitionsFollowerByFilter(
      getRequestFilterRequest: GetRequestFilterRequest(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
        statuses: status,
        page: page ?? 1,
        departmentIds: departmentId,
        type: type,
      ),
    );
    return response?.data;
  }

  @override
  Future<RequestsResponse?> getRequisitionsSelfByFilter({
    int? page,
    List<String>? flowId,
    DateTime? startDate,
    DateTime? endDate,
    StatusRequestEnum? status,
  }) async {
    final response = await _requestService.getRequisitionsSelfByFilter(
      getRequestFilterRequest: GetRequestFilterRequest(
        flowIds: flowId,
        page: page ?? 1,
        endDate: endDate,
        startDate: startDate,
        statuses: status,
      ),
    );
    return response?.data;
  }

  @override
  Future<bool?> userRejectRequisitionById({required String id}) async {
    final response = await _requestService.userRejectRequisitionById(id: id);
    return response?.data;
  }

  @override
  Future<Request?> editRequestEdit(
      {required PostRequestRequest postRequestRequest}) async {
    final response = await _requestService.editRequestEdit(
        postRequestRequest: postRequestRequest);
    return response?.data;
  }

  @override
  Future<RequestsResponse?> getRequestsByIds(
      {required List<String> ids}) async {
    final response = await _requestService.getRequestsByIds(
      getRequestsByIds: GetRequestsByIds(ids: ids),
    );
    final requestsResponse = RequestsResponse(items: response?.result ?? []);
    return requestsResponse;
  }

  @override
  Future<void> cancelRequestsById(
      {required CancelRequest cancelRequest}) async {
    await _requestService.cancelRequestsById(
      cancelRequest: cancelRequest,
    );
  }

  @override
  Future<ApproveRequisitionCountStatusResponse?> approveRequisitionCountStatus(
      {required GetRequestApproveFilterRequest
          getRequestApproveFilterRequest}) async {
    final response = await _requestService.approveRequisitionCountStatus(
      getRequestApproveFilterRequest: getRequestApproveFilterRequest,
    );
    return response?.data;
  }

  @override
  Future<ApproveRequisitionCountStatusResponse?> userRequisitionCountStatus(
      {required GetRequestFilterRequest getRequestFilterRequest}) async {
    final response = await _requestService.userRequisitionCountStatus(
      getRequestFilterRequest: getRequestFilterRequest,
    );
    return response?.data;
  }

  @override
  Future<bool> approveRequisitions(
      {required ApprovesStepRequest approvesStepRequest}) async {
    final result = await _requestService.approveRequisitions(
        approvesStepRequest: approvesStepRequest);
    return result?.data ?? false;
  }
}
