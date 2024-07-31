import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/flow/flow_response.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_response.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/repositories/requisition.repository.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RequisitionUseCase)
class RequisitionUseCaseImpl extends RequisitionUseCase {
  final RequisitionRepository _requisitionRepository;

  RequisitionUseCaseImpl() : _requisitionRepository = dI<RequisitionRepository>();

  @override
  Future<bool> approveRequest({required String id, String? note, required String status}) async {
    return await _requisitionRepository.approveRequisition(id: id, status: status, note: note);
  }

  @override
  Future<Request> getRequisitionById({required String id}) async {
    return await _requisitionRepository.getRequisitionById(id: id);
  }

  @override
  Future<FlowResponse> getFlowByUser({required int page}) async {
    return await _requisitionRepository.getFlowByUser(page: page);
  }

  @override
  Future<Request> postRequest({required PostRequestRequest postRequestRequest}) async {
    return await _requisitionRepository.postRequest(postRequestRequest: postRequestRequest);
  }

  @override
  Future<SearchStationeryByNameResponse> getStationery(
      {required String name, required int page}) async {
    return await _requisitionRepository.getStationery(name: name, page: page);
  }

  @override
  Future<FlowRequest> getFlowById({required String id}) async {
    return await _requisitionRepository.getFlowById(id: id);
  }

  @override
  Future<RequestsResponse> getRequisitionsApproveByFilter({
    int? page,
    List<RequisitionTypeEnum>? type,
    String? departmentId,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    EnumStepRequestStatusEnum? status,
  }) async {
    return await _requisitionRepository.getRequisitionsApproveByFilter(
      page: page,
      status: status,
      endDate: endDate,
      startDate: startDate,
      userId: userId,
      type: type,
      departmentId: departmentId,
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
    return await _requisitionRepository.getRequisitionsFollowerByFilter(
      page: page,
      endDate: endDate,
      startDate: startDate,
      status: status,
      type: type,
      departmentId: departmentId,
      userId: userId,
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
    return await _requisitionRepository.getRequisitionsSelfByFilter(
      page: page,
      endDate: endDate,
      startDate: startDate,
      status: status,
      flowId: flowId,
    );
  }

  @override
  Future<bool> userRejectRequisitionById({required String id}) async {
    return await _requisitionRepository.userRejectRequisitionById(id: id);
  }

  @override
  Future<Request> editRequestEdit({required PostRequestRequest postRequestRequest}) async {
    return await _requisitionRepository.editRequestEdit(postRequestRequest: postRequestRequest);
  }

  @override
  Future<RequestsResponse> getRequestsByIds({required List<String> ids}) async {
    return await _requisitionRepository.getRequestsByIds(ids: ids);
  }
}
