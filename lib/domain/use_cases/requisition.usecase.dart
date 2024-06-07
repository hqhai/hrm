import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/reqisition/requisition.dart';

abstract class RequisitionUseCase {
  Future<List<Requisition>> getRequisitions({int? page});

  Future<List<Requisition>> getRequisitionsByFilter({
    int? page,
    RequisitionTypeEnum? type,
    String? departmentId,
    String? startDate,
    String? endDate,
    List<StatusRequisitionEnum>? status,
  });

  Future<List<Requisition>> getRequisitionsApprove({int? page});

  Future<List<Requisition>> getRequisitionsApproveByFilter({
    int? page,
    RequisitionTypeEnum? type,
    String? departmentId,
    String? startDate,
    String? endDate,
    List<StatusRequisitionEnum>? status,
  });

  Future<Requisition> getRequisition({required String id});

  Future<int> approveRequisition({required String id, String? note, required String status});
}
