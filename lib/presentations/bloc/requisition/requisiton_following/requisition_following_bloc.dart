import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequisitionFollowingBloc extends HydratedBloc<RequisitionFollowingEvent, RequisitionFollowingState> {
  final RequisitionUseCase requisitionUseCase;

  RequisitionFollowingBloc()
      : requisitionUseCase = dI<RequisitionUseCase>(),
        super(const RequisitionFollowingState()) {
    on<RequisitionFollowingEvent>((event, emit) {});
    on<GetRequisitionsFollowingByFilterEvent>(_getRequisitionsFollowingByFilterEvent);
    on<ResetRequisitionFollowingEvent>(_resetRequisitionFollowingEvent);
  }

  ///get by filter ***********************************************
  FutureOr<void> _getRequisitionsFollowingByFilterEvent(
      GetRequisitionsFollowingByFilterEvent event, Emitter<RequisitionFollowingState> emit) async {
    try {
      final RequestsResponse requestsResponse =
          await requisitionUseCase.getRequisitionsFollowerByFilter(
        page: event.page,
        departmentId: event.departmentId,
        endDate: event.endTime,
        startDate: event.startTime,
        type: event.type,
        userId: event.userIds,
        status: event.status,
      );
      final List<Request> newRequest = requestsResponse.items;
      final int totalItems = requestsResponse.pagingInfo.totalItems;
      final Map<String, Request> mapRequests = Map.fromEntries(
        newRequest.map(
          (item) => MapEntry(
            item.id,
            item,
          ),
        ),
      );
      final List<String> requestsIds = newRequest.map((e) => e.id).toList();
      if (event.page != 1) {
        final Map<String, Request> requests = state.requisitions;
        requests.addAll(mapRequests);
        final oldRequestsIds = [...state.requisitionIds, ...requestsIds];
        emit(state.copyWith(
          errorCode: '',
          requisitionIds: oldRequestsIds,
          requisitions: requests,
          countItem: totalItems,
        ));
        event.completer?.complete(true);
      } else {
        emit(state.copyWith(
          errorCode: '',
          requisitionIds: requestsIds,
          requisitions: mapRequests,
          countItem: totalItems,
        ));
        event.completer?.complete(true);
      }
    } catch (e) {
      event.completer?.complete(false);
      e as ResponseBase;
      final String? errorCode = e.errorMessages.first.errorCode;
      emit(state.copyWith(errorCode: errorCode));
    }
  }

  @override
  RequisitionFollowingState? fromJson(Map<String, dynamic> json) {
    return RequisitionFollowingState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(RequisitionFollowingState state) {
    return state.toJson();
  }

  FutureOr<void> _resetRequisitionFollowingEvent(ResetRequisitionFollowingEvent event, Emitter<RequisitionFollowingState> emit) {
    emit(const RequisitionFollowingState());
  }
}
