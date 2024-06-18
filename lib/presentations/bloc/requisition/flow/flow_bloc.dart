import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/data/models/requisition/flow/flow_response.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FlowBloc extends Bloc<FlowEvent, FlowState> {
  final RequisitionUseCase requisitionUseCase;

  FlowBloc()
      : requisitionUseCase = dI<RequisitionUseCase>(),
        super(const FlowState()) {
    on<FlowEvent>((event, emit) {});
    on<GetFlowsEvent>(_getFlowsEvent);
    on<GetFlowEvent>(_getFlowEvent);
  }

  FutureOr<void> _getFlowsEvent(GetFlowsEvent event, Emitter<FlowState> emit) async {
    emit(state.copyWith(status: FlowStatusEnum.getFlowsInit));
    try {
      FlowResponse flowResponse = await requisitionUseCase.getFlowByUser(page: event.page);
      List<FlowRequest> flows = flowResponse.flows;
      //int total = flowResponse.totalItems;
      emit(state.copyWith(flows: flows, status: FlowStatusEnum.getFlowsSuccess));
    } catch (e) {
      emit(state.copyWith(status: FlowStatusEnum.getFlowsError));
    }
  }

  FutureOr<void> _getFlowEvent(GetFlowEvent event, Emitter<FlowState> emit) async {
    emit(state.copyWith(status: FlowStatusEnum.getFlowInit));
    try {
      FlowRequest flow = await requisitionUseCase.getFlowById(id: event.id);
      emit(
        state.copyWith(
          flow: flow,
          status: FlowStatusEnum.getFlowSuccess,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FlowStatusEnum.getFlowError));
    }
  }
}
