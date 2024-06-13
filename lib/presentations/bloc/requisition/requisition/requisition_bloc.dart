import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequisitionBloc extends Bloc<RequisitionEvent, RequisitionState> {
  final RequisitionUseCase requisitionUseCase;

  RequisitionBloc()
      : requisitionUseCase = dI<RequisitionUseCase>(),
        super(const RequisitionState()) {
    on<RequisitionEvent>((event, emit) {});
    on<GetRequisitionsEvent>(_getRequisitionsEvent);
    on<GetRequisitionsByFilterEvent>(_getRequisitionsByFilterEvent);
    on<GetRequisitionByIdEvent>(_getRequisitionByIdEvent);
    on<PostRequestEvent>(_postRequestEvent);
  }

  FutureOr<void> _getRequisitionsEvent(
      GetRequisitionsEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.getRequisitionsSuccess));
    try {
      List<Request> requests = [];
      RequestsResponse requestsResponse = await requisitionUseCase.getRequests(
        page: event.page,
      );
      List<Request> newStationery = requestsResponse.requests;
      int totalItems = requestsResponse.totalItems;
      requests.addAll(state.requisitions);
      requests.addAll(newStationery);
      emit(state.copyWith(
          requisitions: requests,
          countItem: totalItems,
          status: RequisitionEnum.getRequisitionsSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.getRequisitionsError));
    }
  }

  FutureOr<void> _getRequisitionsByFilterEvent(
      GetRequisitionsByFilterEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.getRequisitionsInit));
    try {
      List<Request> requests = [];
      RequestsResponse requestsResponse = await requisitionUseCase.getRequisitionsByFilter(
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

  FutureOr<void> _getRequisitionByIdEvent(
      GetRequisitionByIdEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.getRequisitionInit));
    try {
      Request request = await requisitionUseCase.getRequisitionById(id: event.id ?? "");
      emit(state.copyWith(requisition: request, status: RequisitionEnum.getRequisitionSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.getRequisitionsError));
    }
  }

  //Post Request
  FutureOr<void> _postRequestEvent(PostRequestEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.postRequisitionInit));
    try {
      await requisitionUseCase.postRequest(postRequestRequest: event.postRequestRequest);
      emit(state.copyWith(status: RequisitionEnum.postRequisitionSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.postRequisitionError));
    }
  }
}
