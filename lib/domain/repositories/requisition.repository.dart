import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';

abstract class RequisitionRepository{
  Future<List<Request>> getRequisitions({int? page});

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
}