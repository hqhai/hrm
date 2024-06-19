import 'package:base_app/data/models/requisition/flow/flow_response.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_response.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';

abstract class RequisitionRepository {
  Future<Request> postRequest({required PostRequestRequest postRequestRequest});

  Future<RequestsResponse> getRequisitions({int? page});

  Future<RequestsResponse> getRequisitionsByFilter({
    int? page,
    String? flowId,
    String? departmentId,
    String? startDate,
    String? endDate,
    List<String>? status,
  });

  Future<RequestsResponse> getRequisitionsApprove({int? page});

  Future<RequestsResponse> getRequisitionsApproveByFilter(
      {int? page,
      String? type,
      String? departmentId,
      String? startDate,
      String? endDate,
      String? status});

  Future<RequestsResponse> getRequisitionsFollowerByFilter({
    int? page,
    String? type,
    String? departmentId,
    String? startDate,
    String? endDate,
    List<String>? status,
  });

  Future<Request> getRequisitionById({required String id});

  Future<bool> approveRequisition({required String id, String? note, required String status});

  Future<FlowResponse> getFlowByUser({required int page});

  Future<FlowRequest> getFlowById({required String id});

  Future<SearchStationeryByNameResponse> getStationery({required String name, required int page});

  Future<bool> userRejectRequisitionById({required String id});

  Future<Request> editRequestEdit({required PostRequestRequest postRequestRequest});
}
