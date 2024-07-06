import 'dart:async';
import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/requisition/requisition/config_request_model.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/request_response.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/use_cases/request_usecase.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_event.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequisitionBloc extends Bloc<RequisitionEvent, RequisitionState> {
  final RequisitionUseCase requisitionUseCase;
  final RequestUseCase _requestUseCase;

  RequisitionBloc()
      : requisitionUseCase = dI<RequisitionUseCase>(),
        _requestUseCase = dI<RequestUseCase>(),
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
      final List<Request> requests = [...state.requisitions];
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
        startDate: event.startTime?.subtract(const Duration(hours: 7)),
        endDate: event.endTime?.subtract(const Duration(hours: 7)),
      );
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
        event.completer?.complete(true);
      }
      // load more *********************
      else {
        emit(state.copyWith(
          requisitions: newRequest,
          countItem: totalItems,
          status: RequisitionEnum.success,
        ));
        event.completer?.complete(true);
      }
    } catch (e) {
      emit(state.copyWith(status: RequisitionEnum.fail));
      event.completer?.complete(false);
    }
  }

//get by id     ***********************************************
  FutureOr<void> _getRequisitionByIdEvent(
      GetRequisitionByIdEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(statusGetById: RequisitionEnum.init));
    try {
      final request = await requisitionUseCase.getRequisitionById(
        id: event.id ?? "",
      );

      dI<FlowBloc>().add(GetFlowEvent(id: request.flowId));
      dI<UserByIdBloc>().add(
        GetSubtitudePersonsByIdEvent(
          ids: request.config.subtitudePersons ?? [],
        ),
      );
      dI<UserByIdBloc>().add(
        GetUsersByIdEvent(ids: request.followerIds),
      );
      event.completer?.complete(RequisitionEnum.success);
      emit(state.copyWith(requisition: request, statusGetById: RequisitionEnum.success));
    } catch (e) {
      emit(state.copyWith(statusGetById: RequisitionEnum.fail));
      event.completer?.complete(RequisitionEnum.fail);
    }
  }

  //Post Request     ***********************************************
  FutureOr<void> _postRequestEvent(PostRequestEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.init));
    try {
      if (event.files.isNotEmpty) {
        final List<String> paths = [...await listPaths(event.files)];
        final ConfigRequestModel configRequestModel = event.postRequestRequest.config;
        final PostRequestRequest postRequestRequest = event.postRequestRequest
            .copyWith(config: configRequestModel.copyWith(attachments: paths));
        await requisitionUseCase.postRequest(postRequestRequest: postRequestRequest);
        emit(state.copyWith(errorCode: '', status: RequisitionEnum.success));
        event.completer.complete(RequisitionEnum.success);
      } else {
        await requisitionUseCase.postRequest(postRequestRequest: event.postRequestRequest);
        emit(state.copyWith(errorCode: '', status: RequisitionEnum.success));
        event.completer.complete(RequisitionEnum.success);
      }
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

  Future<List<String>> listPaths(List<File> files) async {
    List<Future<String>> futures = files.map((file) async {
      return await _requestUseCase.uploadFile(originFile: file);
    }).toList();
    List<String> paths = await Future.wait(futures);
    return paths;
  }

  //Edit Request     ***********************************************
  FutureOr<void> _editRequestEvent(EditRequestEvent event, Emitter<RequisitionState> emit) async {
    emit(state.copyWith(status: RequisitionEnum.init));
    try {
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
