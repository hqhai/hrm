import 'dart:async';

import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/exception/remote/remote_exception.dart';
import 'package:base_app/data/models/requisition/flow/flow_response.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/domain/use_cases/requisition_usecase.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FlowBloc extends HydratedBloc<FlowEvent, FlowState> {
  final RequisitionUseCase requisitionUseCase;

  FlowBloc(this.requisitionUseCase) : super(const FlowState()) {
    on<FlowEvent>((event, emit) {});
    on<GetFlowsEvent>(_getFlowsEvent);
    on<GetFlowEvent>(_getFlowEvent);
    on<ResetFlowEvent>(_resetFlowEvent);
  }

  FutureOr<void> _getFlowsEvent(GetFlowsEvent event, Emitter<FlowState> emit) async {
    emit(state.copyWith(statusGet: FlowStatusEnum.init));
    try {
      final FlowResponse flowResponse = await requisitionUseCase.getFlowByUser(page: event.page);
      final newFlows = flowResponse.items.where((element) => element.flowType != RequisitionTypeEnum.postalDelivery).toList();
      final int total = flowResponse.pagingInfo.totalItems;
      emit(state.copyWith(
        flows: newFlows,
        statusGet: FlowStatusEnum.success,
        totalItems: total,
        errorCode: null,
      ));
      event.completer?.complete(true);
    } catch (e) {
      if (e is RemoteException) {
        final listErrorCode = e.serverError?.errors.map((e) => e).toList();
        if (listErrorCode != null && listErrorCode.isNotEmpty) {
          emit(
            state.copyWith(statusGet: FlowStatusEnum.fail, errorCode: listErrorCode.first),
          );
        } else {
          emit(
            state.copyWith(statusGet: FlowStatusEnum.fail, errorCode: ''),
          );
        }
      } else {
        emit(
          state.copyWith(
            statusGet: FlowStatusEnum.fail,
            errorCode: '',
          ),
        );
      }
      event.completer?.complete(false);
    }
  }

  FutureOr<void> _getFlowEvent(GetFlowEvent event, Emitter<FlowState> emit) async {
    emit(state.copyWith(statusGetById: FlowStatusEnum.init));
    try {
      final FlowRequest flow = await requisitionUseCase.getFlowById(id: event.id);
      emit(state.copyWith(
        flow: flow,
        statusGetById: FlowStatusEnum.success,
        errorCode: null,
      ));
      event.completer?.complete(true);
    } catch (e) {
      emit(state.copyWith(statusGetById: FlowStatusEnum.fail));
      event.completer?.complete(false);
    }
  }

  @override
  FlowState? fromJson(Map<String, dynamic> json) {
    return FlowState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(FlowState state) {
    return state.toJson();
  }

  FutureOr<void> _resetFlowEvent(ResetFlowEvent event, Emitter<FlowState> emit) {
    emit(
      state.copyWith(
        flow: const FlowRequest(id: ''),
      ),
    );
  }
}
