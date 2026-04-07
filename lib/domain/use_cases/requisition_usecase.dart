import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/models/requisition/flow_response.dart';
import 'package:base_app/domain/models/requisition/post_request_request.dart';
import 'package:base_app/domain/models/requisition/request_response.dart';
import 'package:base_app/domain/models/requisition/approve/approves_step_request.dart';
import 'package:base_app/domain/models/requisition/search_stationery_by_name_response.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/repositories/requisition.repository.dart';
import 'package:injectable/injectable.dart';

import 'package:base_app/domain/models/requisition/approve/cancel_request.dart';
import 'package:base_app/domain/models/requisition/approve/get_request_approve_filter_request.dart';
import 'package:base_app/domain/models/requisition/approve/get_request_filter_request.dart';
import 'package:base_app/domain/models/requisition/approve_requisition_count_status_response.dart';

@Injectable()
class RequisitionUseCase {
  final RequisitionRepository _requisitionRepository;

  RequisitionUseCase(this._requisitionRepository);

  Future<bool> approveRequest(
      {required String id, String? note, required String status}) async {
    final response = await _requisitionRepository.approveRequisition(
        id: id, status: status, note: note);
    return response ?? false;
  }

  Future<Request> getRequisitionById({required String id}) async {
    final response = await _requisitionRepository.getRequisitionById(id: id);
    return response ?? const Request();
  }

  Future<FlowResponse> getFlowByUser({required int page}) async {
    final response = await _requisitionRepository.getFlowByUser(page: page);
    return response ?? const FlowResponse();
  }

  Future<Request> postRequest(
      {required PostRequestRequest postRequestRequest}) async {
    final response = await _requisitionRepository.postRequest(
        postRequestRequest: postRequestRequest);
    return response ?? const Request();
  }

  Future<SearchStationeryByNameResponse> getStationery(
      {required String name, required int page}) async {
    final response =
        await _requisitionRepository.getStationery(name: name, page: page);
    return response ?? const SearchStationeryByNameResponse();
  }

  Future<FlowRequest> getFlowById({required String id}) async {
    final response = await _requisitionRepository.getFlowById(id: id);
    return response ?? const FlowRequest();
  }

  Future<RequestsResponse> getRequisitionsApproveByFilter({
    int? page,
    List<RequisitionTypeEnum>? type,
    String? departmentId,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    EnumStepRequestStatusEnum? status,
  }) async {
    final response =
        await _requisitionRepository.getRequisitionsApproveByFilter(
      page: page,
      status: status,
      endDate: endDate,
      startDate: startDate,
      userId: userId,
      type: type,
      departmentId: departmentId,
    );
    return response ?? const RequestsResponse();
  }

  Future<RequestsResponse> getRequisitionsFollowerByFilter(
      {int? page,
      List<RequisitionTypeEnum>? type,
      String? departmentId,
      String? userId,
      DateTime? startDate,
      DateTime? endDate,
      StatusRequestEnum? status}) async {
    final response =
        await _requisitionRepository.getRequisitionsFollowerByFilter(
      page: page,
      endDate: endDate,
      startDate: startDate,
      status: status,
      type: type,
      departmentId: departmentId,
      userId: userId,
    );
    return response ?? const RequestsResponse();
  }

  Future<RequestsResponse> getRequisitionsSelfByFilter({
    int? page,
    List<String>? flowId,
    DateTime? startDate,
    DateTime? endDate,
    StatusRequestEnum? status,
  }) async {
    final response = await _requisitionRepository.getRequisitionsSelfByFilter(
      page: page,
      endDate: endDate,
      startDate: startDate,
      status: status,
      flowId: flowId,
    );
    return response ?? const RequestsResponse();
  }

  Future<bool> userRejectRequisitionById({required String id}) async {
    final response =
        await _requisitionRepository.userRejectRequisitionById(id: id);
    return response ?? false;
  }

  Future<Request> editRequestEdit(
      {required PostRequestRequest postRequestRequest}) async {
    final response = await _requisitionRepository.editRequestEdit(
        postRequestRequest: postRequestRequest);
    return response ?? const Request();
  }

  Future<RequestsResponse> getRequestsByIds({required List<String> ids}) async {
    final response = await _requisitionRepository.getRequestsByIds(ids: ids);
    return response ?? const RequestsResponse();
  }

  Future<void> cancelRequestsById(
      {required CancelRequest cancelRequest}) async {
    await _requisitionRepository.cancelRequestsById(
        cancelRequest: cancelRequest);
  }

  Future<ApproveRequisitionCountStatusResponse> approveRequisitionCountStatus(
      {required GetRequestApproveFilterRequest
          getRequestApproveFilterRequest}) async {
    final response = await _requisitionRepository.approveRequisitionCountStatus(
        getRequestApproveFilterRequest: getRequestApproveFilterRequest);
    return response ?? const ApproveRequisitionCountStatusResponse();
  }

  Future<ApproveRequisitionCountStatusResponse> userRequisitionCountStatus(
      {required GetRequestFilterRequest getRequestFilterRequest}) async {
    final response = await _requisitionRepository.userRequisitionCountStatus(
        getRequestFilterRequest: getRequestFilterRequest);
    return response ?? const ApproveRequisitionCountStatusResponse();
  }

  Future<bool> approveRequisitions(
      {required ApprovesStepRequest approvesStepRequest}) async {
    return await _requisitionRepository.approveRequisitions(
        approvesStepRequest: approvesStepRequest);
  }
}
