import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/response.dart';
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
    on<EditRequestEvent>(_editRequestEvent);
  }

  //Reject request      ***********************************************
  FutureOr<void> _userRejectRequestEvent(
      UserRejectRequestEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.init));
    try {
      final int requestIndex = state.requisitions.indexWhere((element) => element.id == event.id);
      final List<Request> requests = state.requisitions;
      final bool check = await requisitionUseCase.userRejectRequisitionById(id: event.id ?? "");
      if (check) {
        requests.removeAt(requestIndex);
        emit(state.copyWith(requisitions: requests, status: RequisitionEnum.success));
      } else {
        emit(state.copyWith(status: RequisitionEnum.fail));
      }
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.fail));
    }
  }

  //get by filter ***********************************************
  FutureOr<void> _getRequisitionsByFilterEvent(
      GetRequisitionsByFilterEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.init));
    try {
      final RequestsResponse requestsResponse = await requisitionUseCase.getRequisitionsByFilter(
          page: event.page,
          flowId: event.flowId != '' ? event.flowId : null,
          status: event.listStatusRequisition?.map((e) => e.name).toList(),
          startDate: event.startTime,
          endDate: event.endTime);
      final List<Request> newRequest = requestsResponse.items;
      final int totalItems = requestsResponse.pagingInfo.totalItems;
      // load more *********************
      if (event.page != 1) {
        final List<Request> requests = [...state.requisitions];
        requests.addAll(state.requisitions);
        requests.addAll(newRequest);
        emit(state.copyWith(
          requisitions: requests,
          countItem: totalItems,
          status: RequisitionEnum.success,
        ));
      }
      // load more *********************
      else {
        emit(state.copyWith(
          requisitions: newRequest,
          countItem: totalItems,
          status: RequisitionEnum.success,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.fail));
    }
  }

//get by id     ***********************************************
  FutureOr<void> _getRequisitionByIdEvent(
      GetRequisitionByIdEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(statusGetById: RequisitionEnum.init));
    try {
      final Request request = await requisitionUseCase.getRequisitionById(
        id: event.id ?? "",
      );
      emit(state.copyWith(requisition: request, statusGetById: RequisitionEnum.success));
    } catch (e) {
      emit(state.copyWith(statusGetById: RequisitionEnum.fail));
    }
  }

  //Post Request     ***********************************************
  FutureOr<void> _postRequestEvent(PostRequestEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.init));
    try {
      await requisitionUseCase.postRequest(postRequestRequest: event.postRequestRequest);
      emit(state.copyWith(errorCode: '', status: RequisitionEnum.success));
      event.completer.complete(RequisitionEnum.success);
    } catch (e) {
      e as ResponseBase;
      if (e.statusCode == 400) {
        final String? errorCode = e.errorMessages.first.errorCode;
        emit(state.copyWith(errorCode: errorCode, status: RequisitionEnum.fail));
        event.completer.complete(RequisitionEnum.fail);
      } else {
        emit(state.copyWith(errorCode: '', status: RequisitionEnum.fail));
        event.completer.complete(RequisitionEnum.fail);
      }
    }
  }

  //Edit Request     ***********************************************
  FutureOr<void> _editRequestEvent(EditRequestEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.init));
    try {
      print('request: ${state.requisition}');
      final int requestIndex =
          state.requisitions.indexWhere((element) => element.id == event.postRequestRequest.id);
      final Request request =
          await requisitionUseCase.editRequestEdit(postRequestRequest: event.postRequestRequest);
      final List<Request> requests = [...state.requisitions];
      requests[requestIndex] = request;
      emit(state.copyWith(
          errorCode: '',
          requisition: request,
          requisitions: requests,
          status: RequisitionEnum.success));
      event.completer.complete(RequisitionEnum.success);
    } catch (e) {
      e as ResponseBase;
      if (e.statusCode == 400) {
        final String? errorCode = e.errorMessages.first.errorCode;
        emit(state.copyWith(errorCode: errorCode, status: RequisitionEnum.fail));
        state.requisition;
      } else {
        emit(state.copyWith(status: RequisitionEnum.fail));
      }
    event.completer.complete(RequisitionEnum.fail);
    }
  }
}
