import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_event.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequestWorkSheetBloc extends HydratedBloc<RequestWorkSheetEvent, RequestWorkSheetState> {
  final RequisitionUseCase requisitionUseCase;

  RequestWorkSheetBloc()
      : requisitionUseCase = dI<RequisitionUseCase>(),
        super(const RequestWorkSheetState()) {
    on<RequestWorkSheetEvent>((event, emit) {});
    on<GetRequestsByIdsEvent>(_getRequestsByIdsEvent);
    on<ResetRequestWorkSheetEvent>(_resetRequestWorkSheetEvent);
  }

  FutureOr<void> _getRequestsByIdsEvent(
      GetRequestsByIdsEvent event, Emitter<RequestWorkSheetState> emit) async {
    try {
      final requestsResponse = await requisitionUseCase.getRequestsByIds(ids: event.ids);
      final requests = requestsResponse.items;
      final Map<String, Request> mapRequests = Map.fromEntries(
        requests.map(
          (item) => MapEntry(item.id, item),
        ),
      );
      final List<String> requestIds = requests.map((e) => e.id).toList();
      emit(state.copyWith(requestIds: requestIds, mapRequests: mapRequests));
      event.completer?.complete(true);
    } catch (e) {
      event.completer?.complete(false);
    }
  }

  @override
  RequestWorkSheetState? fromJson(Map<String, dynamic> json) {
    return RequestWorkSheetState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(RequestWorkSheetState state) {
    return state.toJson();
  }

  FutureOr<void> _resetRequestWorkSheetEvent(ResetRequestWorkSheetEvent event, Emitter<RequestWorkSheetState> emit) {
    emit(const RequestWorkSheetState());
  }
}
