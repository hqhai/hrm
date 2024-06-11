import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/repositories/requisition.repository.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: RequisitionUseCase)
class RequisitionUseCaseImpl extends RequisitionUseCase {
  final RequisitionRepository _requisitionRepository;
  RequisitionUseCaseImpl() : _requisitionRepository = dI<RequisitionRepository>();

  @override
  Future<int> approveRequest({required String id, String? note, required String status}) {
    // TODO: implement approveRequest
    throw UnimplementedError();
  }

  @override
  Future<List<Request>> getRequests({int? page}) {
    // TODO: implement getRequests
    throw UnimplementedError();
  }

  @override
  Future<Request> getRequisition({required String id}) {
    // TODO: implement getRequisition
    throw UnimplementedError();
  }

  @override
  Future<List<Request>> getRequisitionsApprove({int? page}) {
    // TODO: implement getRequisitionsApprove
    throw UnimplementedError();
  }

  @override
  Future<List<Request>> getRequisitionsApproveByFilter({int? page, StatusRequestEnum? type, String? departmentId, String? startDate, String? endDate, List<StatusRequestEnum>? status}) {
    // TODO: implement getRequisitionsApproveByFilter
    throw UnimplementedError();
  }

  @override
  Future<List<Request>> getRequisitionsByFilter({int? page, StatusRequestEnum? type, String? departmentId, String? startDate, String? endDate, List<StatusRequestEnum>? status}) {
    // TODO: implement getRequisitionsByFilter
    throw UnimplementedError();
  }

  @override
  Future<List<Flow>> getFlowByUser() async {
    return await _requisitionRepository.getFlowByUser();
  }
}
