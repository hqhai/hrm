import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_response.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';

abstract class RequisitionUseCase {
  Future<int> postRequest({required PostRequestRequest postRequestRequest});

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

  Future<SearchStationeryByNameResponse> getStationery({required String name, required int page});

}
