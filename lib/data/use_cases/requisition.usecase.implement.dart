import 'package:base_app/common/configs/locators.dart';
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
  Future<int> approveRequest({required String id, String? note, required String status}) {
    // TODO: implement approveRequest
    throw UnimplementedError();
  }

  @override
  Future<RequestsResponse> getRequests({int? page}) async {
    return await _requisitionRepository.getRequisitions(page: page);
  }

  @override
  Future<Request> getRequisitionById({required String id}) async {
    return await _requisitionRepository.getRequisitionById(id: id);
  }

  @override
  Future<RequestsResponse> getRequisitionsApprove({int? page}) async {
    return await _requisitionRepository.getRequisitionsApprove(page: page);
  }

  @override
  Future<List<Flow>> getFlowByUser() async {
    return await _requisitionRepository.getFlowByUser();
  }

  @override
  Future<int> postRequest({required PostRequestRequest postRequestRequest}) async {
    return await _requisitionRepository.postRequest(postRequestRequest: postRequestRequest);
  }

  @override
  Future<SearchStationeryByNameResponse> getStationery(
      {required String name, required int page}) async {
    return await _requisitionRepository.getStationery(name: name, page: page);
  }

  @override
  Future<Flow> getFlowById({required String id}) async {
    return await _requisitionRepository.getFlowById(id: id);
  }

  @override
  Future<RequestsResponse> getRequisitionsApproveByFilter(
      {int? page,
      String? type,
      String? departmentId,
      String? startDate,
      String? endDate,
      List<String>? status}) async {
    return await _requisitionRepository.getRequisitionsApproveByFilter(
      page: page,
      endDate: endDate,
      startDate: startDate,
      status: status,
      type: type,
      departmentId: departmentId,
    );
  }

  @override
  Future<RequestsResponse> getRequisitionsFollowerByFilter(
      {int? page,
      String? type,
      String? departmentId,
      String? startDate,
      String? endDate,
      List<String>? status}) async {
    return await _requisitionRepository.getRequisitionsFollowerByFilter(
      page: page,
      endDate: endDate,
      startDate: startDate,
      status: status,
      type: type,
      departmentId: departmentId,
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
    return await _requisitionRepository.getRequisitionsByFilter(
      page: page,
      endDate: endDate,
      startDate: startDate,
      status: status,
      type: type,
      departmentId: departmentId,
    );
  }
}
