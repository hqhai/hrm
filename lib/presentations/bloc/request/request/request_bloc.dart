import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/response.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/use_cases/request_usecase.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final RequestUseCase _requestUseCase;

  RequestBloc()
      : _requestUseCase = dI<RequestUseCase>(),
        super(const RequestState()) {
    on<RequestEvent>((event, emit) {});
    on<CreateRequestEventNeedApproval>(_createRequestNeedApproval);
    on<CreateRequestEventNoNeedApproval>(_createRequestNoNeedApproval);
    on<GetRequestEvent>(_getRequestEvent);
    on<GetRequestByIdEvent>(_getRequestByIdEvent);
    on<UpdateRequestByIdEvent>(_updateRequestByIdEvent);
    on<GetRequestByAdminEvent>(_getRequestByAdminEvent);
    on<CreateOvertimeRequestEvent>(_createOvertimeRequestEvent);
    on<ChangeListStatusEvent>(_changeListStatusEvent);
    on<CreateOnLeaveRequestEvent>(_createOnLeaveRequestEvent);
    on<CreateExplanationRequestEvent>(_createExplanationRequestEvent);
    on<CreateRoomMeetingRequestEvent>(_createRoomMeetingRequestEvent);
    on<ResetRequestEvent>(_resetRequestEvent);
    on<GetRequestByUserEvent>(_getRequestByUserEvent);
  }

  FutureOr<void> _createRequestNeedApproval(
      CreateRequestEventNeedApproval event, Emitter<RequestState> emit) async {
    emit(state.copyWith(status: RequestStatus.createRequestInit));
    try {
      if (event.file != null) {
        String path =
            await _requestUseCase.uploadFile(originFile: event.file, imageData: event.imageData);
        await _requestUseCase.createRequest(
          type: event.type,
          isApprove: event.isApprove,
          priority: event.priority,
          filePaths: [path],
          approverId: event.approverId,
          title: event.title,
          content: event.content,
          config: event.config,
        );
        emit(state.copyWith(status: RequestStatus.createRequestSuccess));
      } else {
        await _requestUseCase.createRequest(
          type: event.type,
          isApprove: event.isApprove,
          priority: event.priority,
          filePaths: [],
          approverId: event.approverId,
          title: event.title,
          content: event.content,
          config: event.config,
        );
        emit(state.copyWith(status: RequestStatus.createRequestSuccess));
      }
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.createRequestError));
    }
  }

  FutureOr<void> _createRequestNoNeedApproval(
      CreateRequestEventNoNeedApproval event, Emitter<RequestState> emit) async {
    emit(state.copyWith(status: RequestStatus.createRequestInit));
    try {
      if (event.file?.path != '') {
        String path =
            await _requestUseCase.uploadFile(originFile: event.file, imageData: event.imageData);
        await _requestUseCase.createRequest(
          type: event.type,
          isApprove: event.isApprove,
          priority: event.priority,
          filePaths: [path],
          title: event.title,
          content: event.content,
          config: event.config,
        );
        emit(state.copyWith(status: RequestStatus.createRequestSuccess));
      } else {
        await _requestUseCase.createRequest(
          type: event.type,
          isApprove: event.isApprove,
          priority: event.priority,
          filePaths: [],
          title: event.title,
          content: event.content,
          config: event.config,
        );
        emit(state.copyWith(status: RequestStatus.createRequestSuccess));
      }
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.createRequestError));
    }
  }

  FutureOr<void> _getRequestEvent(GetRequestEvent event, Emitter<RequestState> emit) async {
    emit(state.copyWith(status: RequestStatus.getRequestInit));
    try {
      List<Request> requests = [];
      emit(state.copyWith(
          requests: requests,
          totalItems: 0,
          status: RequestStatus.getRequestSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.getRequestError));
    }
  }

  FutureOr<void> _getRequestByIdEvent(GetRequestByIdEvent event, Emitter<RequestState> emit) async {
    emit(state.copyWith(status: RequestStatus.getRequestByIdInit));
    try {
      Request request = await _requestUseCase.getRequestById(id: event.id);
      emit(state.copyWith(request: request, status: RequestStatus.getRequestByIdSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.getRequestByIdError));
    }
  }

  FutureOr<void> _updateRequestByIdEvent(
      UpdateRequestByIdEvent event, Emitter<RequestState> emit) async {
    emit(state.copyWith(status: RequestStatus.updateRequestInit));
    try {
      if (event.file != null) {
        String path =
            await _requestUseCase.uploadFile(originFile: event.file, imageData: event.imageData);
        await _requestUseCase.updateRequestById(
            id: event.id,
            priority: event.priority,
            filePaths: [path],
            content: event.content,
            title: event.title);
        emit(state.copyWith(status: RequestStatus.updateRequestSuccess));
      } else if (event.file == null && event.path != []) {
        await _requestUseCase.updateRequestById(
          id: event.id,
          filePaths: event.path,
          priority: event.priority,
          content: event.content,
          title: event.title,
        );
        emit(state.copyWith(status: RequestStatus.updateRequestSuccess));
      } else if (event.file == null && event.path == []) {
        await _requestUseCase.updateRequestById(
          id: event.id,
          priority: event.priority,
          content: event.content,
          title: event.title,
        );
        emit(state.copyWith(status: RequestStatus.updateRequestSuccess));
      }
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.updateRequestError));
    }
  }

  FutureOr<void> _getRequestByAdminEvent(
      GetRequestByAdminEvent event, Emitter<RequestState> emit) async {
    emit(state.copyWith(status: RequestStatus.getRequestByAdminInit));
    try {
      final List<Request> requests = await _requestUseCase.getRequestByAdmin(
          type: event.type, endDate: event.endDate, startDate: event.startDate);
      emit(state.copyWith(requests: requests, status: RequestStatus.getRequestByAdminSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.getRequestByAdminError));
    }
  }

  FutureOr<void> _createOvertimeRequestEvent(
      CreateOvertimeRequestEvent event, Emitter<RequestState> emit) async {
    emit(state.copyWith(status: RequestStatus.createRequestInit));
    try {
      await _requestUseCase.createOvertimeRequest(
        type: event.type,
        isApprove: event.isApprove,
        config: event.config,
      );
      emit(state.copyWith(status: RequestStatus.createRequestSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.createRequestError));
    }
  }

  FutureOr<void> _changeListStatusEvent(
      ChangeListStatusEvent event, Emitter<RequestState> emit) async {
    emit(state.copyWith(status: RequestStatus.changeStatusRequestInit));
    try {
      await _requestUseCase.changeListStatus(
          changeStatusRequestCommandModels: event.changeStatusRequestCommandModels,
          enumRequestType: event.enumRequestType);
      emit(state.copyWith(status: RequestStatus.changeStatusRequestSuccess));
    } catch (e) {
      if (e is ResponseBase && e.statusCode == 400) {
        emit(state.copyWith(status: RequestStatus.changeStatusRequestError));
      }
      emit(state.copyWith(status: RequestStatus.changeStatusRequestError));
    }
  }

  FutureOr<void> _createOnLeaveRequestEvent(
      CreateOnLeaveRequestEvent event, Emitter<RequestState> emit) async {
    emit(state.copyWith(status: RequestStatus.createRequestInit));
    try {
      await _requestUseCase.createOnLeaveRequest(
        type: event.type,
        isApprove: event.isApprove,
        priority: event.priority,
        title: event.title,
        content: event.content,
        config: event.config,
      );
      emit(state.copyWith(status: RequestStatus.createRequestSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.createRequestError));
    }
  }

  FutureOr<void> _createExplanationRequestEvent(
      CreateExplanationRequestEvent event, Emitter<RequestState> emit) async {
    emit(state.copyWith(status: RequestStatus.createRequestInit));
    try {
      await _requestUseCase.createExplanationRequest(
        type: event.type,
        isApprove: event.isApprove,
        priority: event.priority,
        title: event.title,
        content: event.content,
        config: event.config,
      );
      emit(state.copyWith(status: RequestStatus.createRequestSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.createRequestError));
    }
  }

  FutureOr<void> _createRoomMeetingRequestEvent(
      CreateRoomMeetingRequestEvent event, Emitter<RequestState> emit) async {
    emit(state.copyWith(status: RequestStatus.roomMeetingInit));
    try {
      int data = await _requestUseCase.createRoomMeetingRequest(
          type: event.type, title: event.title, content: event.content, config: event.config);
      data;
      emit(state.copyWith(status: RequestStatus.createRoomMeetingSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.roomMeetingError));
    }
  }

  FutureOr<void> _resetRequestEvent(ResetRequestEvent event, Emitter<RequestState> emit) async {
    emit(const RequestState(status: RequestStatus.resetRequest));
  }

  FutureOr<void> _getRequestByUserEvent(
      GetRequestByUserEvent event, Emitter<RequestState> emit) async {
    emit(state.copyWith(status: RequestStatus.getRequestInit));
    try {
      List<Request> listRequests = [];
      emit(state.copyWith(requestsByUser: listRequests, status: RequestStatus.getRequestSuccess));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.getRequestError));
    }
  }
}
