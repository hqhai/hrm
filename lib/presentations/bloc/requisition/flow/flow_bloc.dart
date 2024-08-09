import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
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
    emit(state.copyWith(statusGet: FlowStatusEnum.init));
    try {
      final FlowResponse flowResponse = await requisitionUseCase.getFlowByUser(page: event.page);
      final newFlows = flowResponse.items
          .where((element) => element.flowType != RequisitionTypeEnum.postalDelivery)
          .toList();
      final int total = flowResponse.pagingInfo.totalItems;
      emit(state.copyWith(
        flows: newFlows,
        statusGet: FlowStatusEnum.success,
        totalItems: total,
      ));
      event.completer?.complete(true);
    } catch (e) {
      emit(state.copyWith(statusGet: FlowStatusEnum.fail));
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
      ));
      event.completer?.complete(true);
    } catch (e) {
      emit(state.copyWith(statusGetById: FlowStatusEnum.fail));
      event.completer?.complete(false);
    }
  }
}
