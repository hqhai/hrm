import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_response.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';

abstract class RequisitionRepository {
  Future<int> postRequest({required PostRequestRequest postRequestRequest});

  Future<RequestsResponse> getRequisitions({int? page});

  Future<RequestsResponse> getRequisitionsByFilter({
    int? page,
    String? type,
    String? departmentId,
    String? startDate,
    String? endDate,
    List<String>? status,
  });

  Future<RequestsResponse> getRequisitionsApprove({int? page});

  Future<RequestsResponse> getRequisitionsApproveByFilter({
    int? page,
    String? type,
    String? departmentId,
    String? startDate,
    String? endDate,
    String? status
  });

  Future<RequestsResponse> getRequisitionsFollowerByFilter({
    int? page,
    String? type,
    String? departmentId,
    String? startDate,
    String? endDate,
    List<String>? status,
  });

  Future<Request> getRequisitionById({required String id});

  Future<String> approveRequisition({required String id, String? note, required String status});

  Future<List<Flow>> getFlowByUser();

  Future<Flow> getFlowById({required String id});

  Future<SearchStationeryByNameResponse> getStationery({required String name, required int page});
}
