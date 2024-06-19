import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
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
    on<GetRequisitionsByFilterEvent>(_getRequisitionsByFilterEvent);
    on<GetRequisitionByIdEvent>(_getRequisitionByIdEvent);
    on<PostRequestEvent>(_postRequestEvent);
    on<UserRejectRequestEvent>(_userRejectRequestEvent);
  }

  FutureOr<void> _userRejectRequestEvent(
      UserRejectRequestEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(statusReject: RequisitionEnum.init));
    try {
      int requestIndex = state.requisitions.indexWhere((element) => element.id == event.id);
      List<Request> requests = state.requisitions;
      bool check = await requisitionUseCase.userRejectRequisitionById(id: event.id ?? "");
      if (check) {
        requests.removeAt(requestIndex);
        emit(state.copyWith(requisitions: requests, statusReject: RequisitionEnum.success));
      } else {
        emit(state.copyWith(statusReject: RequisitionEnum.fail));
      }
    } catch (e) {
      emit(state.copyWith(statusReject: RequisitionEnum.fail));
    }
  }

  FutureOr<void> _getRequisitionsByFilterEvent(
      GetRequisitionsByFilterEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(statusGetByFilter: RequisitionEnum.init));
    try {
      List<Request> requests = [];
      RequestsResponse requestsResponse = await requisitionUseCase.getRequisitionsByFilter(
        page: event.page,
        flowId: event.flowId != '' ? event.flowId : null,
        status: event.listStatusRequisition?.map((e) => e.name).toList(),
        startDate: event.startTime,
        endDate: event.endTime
      );
      List<Request> newRequest = requestsResponse.requests;
      int totalItems = requestsResponse.totalItems;
      if (event.page != 1) {
        requests.addAll(state.requisitions);
        requests.addAll(newRequest);
        emit(state.copyWith(
          requisitions: requests,
          countItem: totalItems,
          statusGetByFilter: RequisitionEnum.success,
        ));
      } else {
        requests.addAll(newRequest);
        emit(state.copyWith(
          requisitions: requests,
          countItem: totalItems,
          statusGetByFilter: RequisitionEnum.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(statusGetByFilter: RequisitionEnum.fail));
    }
  }

  FutureOr<void> _getRequisitionByIdEvent(
      GetRequisitionByIdEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(statusGetById: RequisitionEnum.init));
    try {
      Request request = await requisitionUseCase.getRequisitionById(id: event.id ?? "");
      emit(state.copyWith(requisition: request, statusGetById: RequisitionEnum.success));
    } catch (e) {
      emit(state.copyWith(statusGetById: RequisitionEnum.fail));
    }
  }

  //Post Request
  FutureOr<void> _postRequestEvent(PostRequestEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(statusPost: RequisitionEnum.init));
    try {
      await requisitionUseCase.postRequest(postRequestRequest: event.postRequestRequest);
      emit(state.copyWith(statusPost: RequisitionEnum.success));
      event.completer.complete();
    } catch (e) {
      emit(state.copyWith(statusPost: RequisitionEnum.fail));
      event.completer.complete();
    }
  }
}
