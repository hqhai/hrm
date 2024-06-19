import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/stationery_enum.dart';
import 'package:base_app/data/models/requisition/staionery/search_stationery_by_name_response.dart';
import 'package:base_app/domain/entities/reqisition/stationery/stationery.dart';
import 'package:base_app/domain/use_cases/requisition.usecase.dart';
import 'package:base_app/presentations/bloc/requisition/stationery/stationery_event.dart';
import 'package:base_app/presentations/bloc/requisition/stationery/stationery_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StationeryBloc extends Bloc<StationeryEvent, StationeryState> {
  final RequisitionUseCase requisitionUseCase;

  StationeryBloc()
      : requisitionUseCase = dI<RequisitionUseCase>(),
        super(const StationeryState()) {
    on<StationeryEvent>((event, emit) {});
    on<GetStationeriesEvent>(_getStationeriesEvent);
  }

  FutureOr<void> _getStationeriesEvent(
      GetStationeriesEvent event, Emitter<StationeryState> emit) async {
    emit(state.copyWith(status: StationeryStatus.init));
    try {
      List<Stationery> stationery = [];
      SearchStationeryByNameResponse searchStationeryByNameResponse =
          await requisitionUseCase.getStationery(page: event.page, name: event.name);
      List<Stationery> newStationery = searchStationeryByNameResponse.items;
      int totalItems = searchStationeryByNameResponse.pagingInfo.totalItems;
      if (event.name == state.name) {
        stationery.addAll(state.stationeries);
        stationery.addAll(newStationery);
        emit(state.copyWith(
            countItem: totalItems, stationeries: stationery, status: StationeryStatus.success));
      } else {
        emit(state.copyWith(
            countItem: totalItems, stationeries: newStationery, status: StationeryStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: StationeryStatus.fail));
    }
  }
}
