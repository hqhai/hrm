import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';

abstract class RequisitionUseCase {
  Future<List<Request>> getRequests({int? page});

  Future<List<Request>> getRequisitionsByFilter({
    int? page,
    StatusRequestEnum? type,
    String? departmentId,
    String? startDate,
    String? endDate,
    List<StatusRequestEnum>? status,
  });

  Future<List<Request>> getRequisitionsApprove({int? page});

  Future<List<Request>> getRequisitionsApproveByFilter({
    int? page,
    StatusRequestEnum? type,
    String? departmentId,
    String? startDate,
    String? endDate,
    List<StatusRequestEnum>? status,
  });

  Future<Request> getRequisition({required String id});

  Future<int> approveRequest({required String id, String? note, required String status});

  Future<List<Flow>> getFlowByUser();

}
