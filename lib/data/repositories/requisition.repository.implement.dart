import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/requisition/flow/flow_by_id_request.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/requisition/get_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/approve_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/get_request_approve_filter_request.dart';
import 'package:base_app/data/models/requisition/requisition/requisition_approve/get_request_filter_request.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_request.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_response.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/repositories/requisition.repository.dart';
import 'package:base_app/domain/services/requisition.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RequisitionRepository)
class RequisitionRepositoryImplement extends RequisitionRepository {
  final RequisitionService _requestService;

  RequisitionRepositoryImplement() : _requestService = dI<RequisitionService>();

  @override
  Future<List<Flow>> getFlowByUser() async {
    return await _requestService.getFlowByUser();
  }

  @override
  Future<int> postRequest({required PostRequestRequest postRequestRequest}) async {
    return await _requestService.postRequest(
      postRequestRequest: postRequestRequest,
    );
  }

  @override
  Future<String> approveRequisition(
      {required String id, String? note, required String status}) async {
    return await _requestService.approveRequisition(
        approveRequest: ApproveRequest(id: id, note: note ?? "", status: status));
  }

  @override
  Future<Request> getRequisitionById({required String id}) async {
    return await _requestService.getRequisitionById(id: id);
  }

  @override
  Future<RequestsResponse> getRequisitions({int? page}) {
    return _requestService.getRequisitions(
      requestsRequest: GetRequestRequest(page: page ?? 0),
    );
  }

  @override
  Future<RequestsResponse> getRequisitionsApprove({int? page}) async {
    return await _requestService.getRequisitionsApprove(
        requestsRequest: GetRequestRequest(page: page ?? 0));
  }

  @override
  Future<SearchStationeryByNameResponse> getStationery(
      {required String name, required int page}) async {
    return await _requestService.getStationery(
        searchStationeryByNameRequest: SearchStationeryByNameRequest(page: page, fullName: name));
  }

  @override
  Future<Flow> getFlowById({required String id}) async {
    return await _requestService.getFlowById(flowByIdRequest: FlowByIdRequest(id: id));
  }

  @override
  Future<RequestsResponse> getRequisitionsFollowerByFilter(
      {int? page,
      String? type,
      String? departmentId,
      String? startDate,
      String? endDate,
      List<String>? status}) async {
    if (status?.isNotEmpty ?? false) {
      return await _requestService.getRequisitionsFollowerByFilter(
        getRequestFilterRequest: GetRequestFilterRequest(
            type: type,
            page: page,
            endDate: endDate,
            startDate: startDate,
            listStatuses: status?.join(','),
            createdDepartmentId: departmentId),
      );
    }
    return await _requestService.getRequisitionsFollowerByFilter(
      getRequestFilterRequest: GetRequestFilterRequest(
          type: type,
          page: page,
          endDate: endDate,
          startDate: startDate,
          createdDepartmentId: departmentId),
    );
  }

  @override
  Future<RequestsResponse> getRequisitionsApproveByFilter(
      {int? page,
      String? type,
      String? departmentId,
      String? startDate,
      String? endDate,
      String? status}) async {
    return await _requestService.getRequisitionsApproveByFilter(
      getRequestApproveFilterRequest: GetRequestApproveFilterRequest(
          type: type,
          page: page,
          endDate: endDate,
          startDate: startDate,
          createdDepartmentId: departmentId,
          statusApprove: status),
    );
  }

  @override
  Future<RequestsResponse> getRequisitionsByFilter(
      {int? page,
      String? type,
      String? departmentId,
      String? startDate,
      String? endDate,
      List<String>? status}) async {
    if (status?.isNotEmpty ?? false) {
      return await _requestService.getRequisitionsByFilter(
        getRequestFilterRequest: GetRequestFilterRequest(
            type: type,
            page: page,
            endDate: endDate,
            startDate: startDate,
            listStatuses: status?.join(','),
            createdDepartmentId: departmentId),
      );
    }
    return await _requestService.getRequisitionsByFilter(
      getRequestFilterRequest: GetRequestFilterRequest(
          type: type,
          page: page,
          endDate: endDate,
          startDate: startDate,
          createdDepartmentId: departmentId),
    );
  }

  @override
  Future<int> userRejectRequisitionById({required String id}) async {
    return await _requestService.userRejectRequisitionById(id: id);
  }
}
