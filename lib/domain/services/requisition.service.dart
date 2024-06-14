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

abstract class RequisitionService {
  Future<int> postRequest({required PostRequestRequest postRequestRequest});

  Future<RequestsResponse> getRequisitions({required GetRequestRequest requestsRequest});

  Future<RequestsResponse> getRequisitionsByFilter({
    required GetRequestFilterRequest getRequestFilterRequest,
  });

  Future<RequestsResponse> getRequisitionsApprove({required GetRequestRequest requestsRequest});

  Future<RequestsResponse> getRequisitionsApproveByFilter({
    required GetRequestApproveFilterRequest getRequestApproveFilterRequest,
  });

  Future<RequestsResponse> getRequisitionsFollowerByFilter({
    required GetRequestFilterRequest getRequestFilterRequest,
  });

  Future<Request> getRequisitionById({required String id});

  Future<String> approveRequisition({required ApproveRequest approveRequest});

  Future<List<Flow>> getFlowByUser();

  Future<Flow> getFlowById({required FlowByIdRequest flowByIdRequest});

  Future<SearchStationeryByNameResponse> getStationery(
      {required SearchStationeryByNameRequest searchStationeryByNameRequest});
}
