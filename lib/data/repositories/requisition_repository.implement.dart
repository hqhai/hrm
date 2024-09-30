import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/flow/flow_by_id_request.dart';
import 'package:base_app/data/models/requisition/flow/flow_response.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request/get_requests_by_ids.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/requisition/get_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/approve_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/get_request_approve_filter_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/get_request_filter_request.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_request.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_response.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/repositories/requisition.repository.dart';
import 'package:base_app/domain/services/requisition.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RequisitionRepository)
class RequisitionRepositoryImplement extends RequisitionRepository {
  final RequisitionService _requestService;

  RequisitionRepositoryImplement() : _requestService = dI<RequisitionService>();

  @override
  Future<FlowResponse> getFlowByUser({required int page}) async {
    return await _requestService.getFlowByUser(
      getRequestRequest: GetRequestRequest(page: page),
    );
  }

  @override
  Future<Request> postRequest(
      {required PostRequestRequest postRequestRequest}) async {
    return await _requestService.postRequest(
      postRequestRequest: postRequestRequest,
    );
  }

  @override
  Future<bool> approveRequisition(
      {required String id, String? note, required String status}) async {
    return await _requestService.approveRequisition(
        approveRequest:
            ApproveRequest(id: id, note: note ?? "", status: status));
  }

  @override
  Future<Request> getRequisitionById({required String id}) async {
    return await _requestService.getRequisitionById(id: id);
  }

  @override
  Future<SearchStationeryByNameResponse> getStationery(
      {required String name, required int page}) async {
    return await _requestService.getStationery(
        searchStationeryByNameRequest:
            SearchStationeryByNameRequest(page: page, product: name));
  }

  @override
  Future<FlowRequest> getFlowById({required String id}) async {
    return await _requestService.getFlowById(
        flowByIdRequest: FlowByIdRequest(id: id));
  }

  @override
  Future<RequestsResponse> getRequisitionsApproveByFilter(
      {int? page,
      List<RequisitionTypeEnum>? type,
      String? departmentId,
      String? userId,
      DateTime? startDate,
      DateTime? endDate,
      EnumStepRequestStatusEnum? status}) async {
    return await _requestService.getRequisitionsApproveByFilter(
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
  }

  @override
  Future<RequestsResponse> getRequisitionsFollowerByFilter(
      {int? page,
      List<RequisitionTypeEnum>? type,
      String? departmentId,
      String? userId,
      DateTime? startDate,
      DateTime? endDate,
      StatusRequestEnum? status}) async {
    return await _requestService.getRequisitionsFollowerByFilter(
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
  }

  @override
  Future<RequestsResponse> getRequisitionsSelfByFilter({
    int? page,
    List<String>? flowId,
    DateTime? startDate,
    DateTime? endDate,
    StatusRequestEnum? status,
  }) async {
    return await _requestService.getRequisitionsSelfByFilter(
      getRequestFilterRequest: GetRequestFilterRequest(
        flowIds: flowId,
        page: page ?? 1,
        endDate: endDate,
        startDate: startDate,
        statuses: status,
      ),
    );
  }

  @override
  Future<bool> userRejectRequisitionById({required String id}) async {
    return await _requestService.userRejectRequisitionById(id: id);
  }

  @override
  Future<Request> editRequestEdit(
      {required PostRequestRequest postRequestRequest}) async {
    return await _requestService.editRequestEdit(
        postRequestRequest: postRequestRequest);
  }

  @override
  Future<RequestsResponse> getRequestsByIds({required List<String> ids}) async {
    return await _requestService.getRequestsByIds(
      getRequestsByIds: GetRequestsByIds(ids: ids),
    );
  }
}
