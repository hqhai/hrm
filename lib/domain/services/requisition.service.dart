import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/requisition/get_request_resquest.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_request.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_response.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';

abstract class RequisitionService{

  Future<int> postRequest({required PostRequestRequest postRequestRequest});
  Future<RequestsResponse> getRequisitions({required GetRequestRequest requestsRequest});

  Future<List<Request>> getRequisitionsByFilter({
    int? page,
    RequisitionTypeEnum? type,
    String? departmentId,
    String? startDate,
    String? endDate,
    List<StatusRequestEnum>? status,
  });

  Future<List<Request>> getRequisitionsApprove({int? page});

  Future<List<Request>> getRequisitionsApproveByFilter({
    int? page,
    RequisitionTypeEnum? type,
    String? departmentId,
    String? startDate,
    String? endDate,
    List<StatusRequestEnum>? status,
  });

  Future<Request> getRequisitionById({required String id});

  Future<int> approveRequisition({required String id, String? note, required String status});

  Future<List<Flow>> getFlowByUser();

  Future<SearchStationeryByNameResponse> getStationery({required SearchStationeryByNameRequest searchStationeryByNameRequest});
}