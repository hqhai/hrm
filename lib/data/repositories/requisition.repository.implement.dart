import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/requisition/get_request_request.dart';
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
  Future<RequestsResponse> getRequisitions({int? page}) {
    return _requestService.getRequisitions(
      requestsRequest: GetRequestRequest(page: page ?? 0),
    );
  }

  @override
  Future<List<Request>> getRequisitionsApprove({int? page}) {
    // TODO: implement getRequisitionsApprove
    throw UnimplementedError();
  }

  @override
  Future<List<Request>> getRequisitionsApproveByFilter(
      {int? page,
      RequisitionTypeEnum? type,
      String? departmentId,
      String? startDate,
      String? endDate,
      List<StatusRequestEnum>? status}) {
    // TODO: implement getRequisitionsApproveByFilter
    throw UnimplementedError();
  }

  @override
  Future<List<Request>> getRequisitionsByFilter(
      {int? page,
      RequisitionTypeEnum? type,
      String? departmentId,
      String? startDate,
      String? endDate,
      List<StatusRequestEnum>? status}) {
    // TODO: implement getRequisitionsByFilter
    throw UnimplementedError();
  }

  @override
  Future<SearchStationeryByNameResponse> getStationery(
      {required String name, required int page}) async {
    return await _requestService.getStationery(
        searchStationeryByNameRequest: SearchStationeryByNameRequest(page: page, fullName: name));
  }
}
