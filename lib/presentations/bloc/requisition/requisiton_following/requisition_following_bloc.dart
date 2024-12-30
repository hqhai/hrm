import 'dart:async';

import 'package:base_app/common/exception/remote/remote_exception.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/use_cases/requisition_usecase.dart';

@lazySingleton
class RequisitionFollowingBloc extends HydratedBloc<RequisitionFollowingEvent, RequisitionFollowingState> {
  final RequisitionUseCase requisitionUseCase;

  RequisitionFollowingBloc(this.requisitionUseCase) : super(const RequisitionFollowingState()) {
    on<RequisitionFollowingEvent>((event, emit) {});
    on<GetRequisitionsFollowingByFilterEvent>(_getRequisitionsFollowingByFilterEvent);
    on<ResetRequisitionFollowingEvent>(_resetRequisitionFollowingEvent);
  }

  ///get by filter ***********************************************
  FutureOr<void> _getRequisitionsFollowingByFilterEvent(GetRequisitionsFollowingByFilterEvent event, Emitter<RequisitionFollowingState> emit) async {
    try {
      final RequestsResponse requestsResponse = await requisitionUseCase.getRequisitionsFollowerByFilter(
        page: event.page,
        departmentId: event.departmentId,
        endDate: event.endTime?.subtract(const Duration(hours: 7)),
        startDate: event.startTime?.subtract(const Duration(hours: 7)),
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
      if (e is RemoteException) {
        final listErrorCode = e.serverError?.errors.map((e) => e).toList();
        if (listErrorCode != null && listErrorCode.isNotEmpty) {
          emit(state.copyWith(
            errorCode: listErrorCode.first,
          ));
        } else {
          emit(state.copyWith(errorCode: 'error'));
        }
        event.completer?.complete(false);
      } else {
        emit(state.copyWith(
          errorCode: 'error',
        ));
        event.completer?.complete(false);
      }
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
