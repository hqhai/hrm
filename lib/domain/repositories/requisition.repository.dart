import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/models/requisition/flow_response.dart';
import 'package:base_app/domain/models/requisition/post_request_request.dart';
import 'package:base_app/domain/models/requisition/request_response.dart';
import 'package:base_app/domain/models/requisition/approve/approves_step_request.dart';
import 'package:base_app/domain/models/requisition/approve/cancel_request.dart';
import 'package:base_app/domain/models/requisition/approve/get_request_approve_filter_request.dart';
import 'package:base_app/domain/models/requisition/approve/get_request_filter_request.dart';
import 'package:base_app/domain/models/requisition/search_stationery_by_name_response.dart';
import 'package:base_app/domain/models/requisition/approve_requisition_count_status_response.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/domain/entities/requisition/request.dart';

abstract class RequisitionRepository {
  Future<Request?> postRequest({required PostRequestRequest postRequestRequest});

  Future<RequestsResponse?> getRequisitionsSelfByFilter({
    int? page,
    List<String>? flowId,
    DateTime? startDate,
    DateTime? endDate,
    StatusRequestEnum? status,
  });

  Future<RequestsResponse?> getRequisitionsApproveByFilter({
    int? page,
    List<RequisitionTypeEnum>? type,
    String? departmentId,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    EnumStepRequestStatusEnum? status,
  });

  Future<RequestsResponse?> getRequisitionsFollowerByFilter({
    int? page,
    List<RequisitionTypeEnum>? type,
    String? departmentId,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    StatusRequestEnum? status,
  });

  Future<Request?> getRequisitionById({required String id});

  Future<bool?> approveRequisition({required String id, String? note, required String status});

  Future<FlowResponse?> getFlowByUser({required int page});

  Future<FlowRequest?> getFlowById({required String id});

  Future<SearchStationeryByNameResponse?> getStationery({required String name, required int page});

  Future<bool?> userRejectRequisitionById({required String id});

  Future<Request?> editRequestEdit({required PostRequestRequest postRequestRequest});

  Future<RequestsResponse?> getRequestsByIds({
    required List<String> ids,
  });

  Future<bool> approveRequisitions(
      {required ApprovesStepRequest approvesStepRequest});

  Future<void> cancelRequestsById({required CancelRequest cancelRequest});

  Future<ApproveRequisitionCountStatusResponse?> approveRequisitionCountStatus({required GetRequestApproveFilterRequest getRequestApproveFilterRequest});

  Future<ApproveRequisitionCountStatusResponse?> userRequisitionCountStatus({required GetRequestFilterRequest getRequestFilterRequest});
}
