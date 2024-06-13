import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/utils/convert.dart';
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
    emit(state.copyWith(status: RequisitionEnum.getRequisitionsSuccess));
    try {
      List<Request> requests = [];
      RequestsResponse requestsResponse = await requisitionUseCase.getRequisitionsFollowerByFilter(
        page: event.page,
        type: event.requisitionTypeEnum?.name,
        status: event.listStatusRequisition?.map((e) => e.name).toList(),
        startDate: event.startTime,
        endDate: event.startTime,
      );
      List<Request> newRequest = requestsResponse.requests;
      int totalItems = requestsResponse.totalItems;
      if (listStatusRequestEquals(event.listStatusRequisition, state.listStatusRequisition) &&
          (state.startTime == event.startTime || event.startTime == null) &&
          (state.endTime == event.endTime || event.endTime == null) &&
          state.requisitionTypeEnum == event.requisitionTypeEnum?.name || event.requisitionTypeEnum == null) {
        requests.addAll(state.requisitions);
        requests.addAll(newRequest);
        emit(state.copyWith(
            endTime: event.endTime,
            startTime: event.startTime,
            requisitionTypeEnum: event.requisitionTypeEnum?.name,
            listStatusRequisition: event.listStatusRequisition,
            requisitions: requests,
            countItem: totalItems,
            status: RequisitionEnum.getRequisitionsSuccess));
      } else {
        requests.addAll(newRequest);
        emit(state.copyWith(
            requisitions: requests,
            countItem: totalItems,
            endTime: event.endTime,
            startTime: event.startTime,
            requisitionTypeEnum: event.requisitionTypeEnum?.name,
            listStatusRequisition: event.listStatusRequisition,
            status: RequisitionEnum.getRequisitionsSuccess));
      }
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.getRequisitionsError));
    }
  }


}
