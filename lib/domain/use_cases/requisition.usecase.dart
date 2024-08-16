import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/flow/flow_response.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_response.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';

abstract class RequisitionUseCase {
  Future<Request> postRequest({required PostRequestRequest postRequestRequest});

  Future<RequestsResponse> getRequisitionsSelfByFilter({
    int? page,
    List<String>? flowId,
    DateTime? startDate,
    DateTime? endDate,
    StatusRequestEnum? status,
  });

  Future<RequestsResponse> getRequisitionsApproveByFilter({
    int? page,
    List<RequisitionTypeEnum>? type,
    String? departmentId,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    EnumStepRequestStatusEnum? status,
  });

  Future<RequestsResponse> getRequisitionsFollowerByFilter({
    int? page,
    List<RequisitionTypeEnum>? type,
    String? departmentId,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    StatusRequestEnum? status,
  });

  Future<Request> getRequisitionById({required String id});

  Future<bool> approveRequest({required String id, String? note, required String status});

  Future<FlowResponse> getFlowByUser({required int page});

  Future<FlowRequest> getFlowById({required String id});

  Future<SearchStationeryByNameResponse> getStationery({required String name, required int page});

  Future<bool> userRejectRequisitionById({required String id});

  Future<Request> editRequestEdit({required PostRequestRequest postRequestRequest});

  Future<RequestsResponse> getRequestsByIds({
    required List<String> ids,
  });

  Future<void> cancelRequestsById({
    required String id,
  });
}
