import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequisitionFollowingBloc extends Bloc<RequisitionFollowingEvent, RequisitionFollowingState> {
  final RequisitionUseCase requisitionUseCase;

  RequisitionFollowingBloc()
      : requisitionUseCase = dI<RequisitionUseCase>(),
        super(const RequisitionFollowingState()) {
    on<RequisitionFollowingEvent>((event, emit) {});
    on<GetRequisitionsFollowingByFilterEvent>(_getRequisitionsFollowingByFilterEvent);
  }

  FutureOr<void> _getRequisitionsFollowingByFilterEvent(
      GetRequisitionsFollowingByFilterEvent event, Emitter<RequisitionFollowingState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.init));
    try {

      final RequestsResponse requestsResponse = await requisitionUseCase.getRequisitionsFollowerByFilter(
        page: event.page,
        type: event.requisitionTypeEnum?.name,
        status: event.listStatusRequisition?.map((e) => e.name).toList(),
        startDate: event.startTime,
        endDate: event.endTime,
      );
      final List<Request> newRequest = requestsResponse.items;
      final int totalItems = requestsResponse.pagingInfo.totalItems;
      if (event.page != 1) {
        final List<Request> requests = [...state.requisitions];
        requests.addAll(newRequest);
        emit(state.copyWith(
            requisitions: requests,
            countItem: totalItems,
            status: RequisitionEnum.success));
      } else {
        emit(state.copyWith(
            requisitions: newRequest,
            countItem: totalItems,
            status: RequisitionEnum.success));
      }
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.fail));
    }
  }


}
