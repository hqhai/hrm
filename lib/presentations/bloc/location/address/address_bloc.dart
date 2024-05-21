import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/domain/use_cases/location.usecase.dart';
import 'package:base_app/presentations/bloc/location/address/address_event.dart';
import 'package:base_app/presentations/bloc/location/address/address_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final LocationUseCase locationUseCase;

  AddressBloc()
      : locationUseCase = dI<LocationUseCase>(),
        super(const AddressState(
            provinces: [], districts: [], wards: [], status: AddressStatus.init)) {
    on<AddressEvent>((event, emit) {});
    on<GetProvincesEvent>(_getProvincesEvent);
    on<GetWardsEvent>(_getWardsEvent);
    on<GetDistrictsEvent>(_getDistrictsEvent);
  }

  FutureOr<void> _getProvincesEvent(GetProvincesEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AddressStatus.getProvincesInit));
    try {
      List<Address> provinces = await locationUseCase.getAddress(page: 1, pageSize: 100, locationType: LocationEnum.province.name);
      emit(state.copyWith(provinces: provinces, status: AddressStatus.getProvincesSuccess));
    } catch (e) {
      emit(state.copyWith(status: AddressStatus.getProvincesError));
    }
  }

  FutureOr<void> _getWardsEvent(GetWardsEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AddressStatus.getWardsInit));
    try {
      List<Address> wards = await locationUseCase.getAddress(page: 1, pageSize: 60, locationType: LocationEnum.ward.name, parentId: event.parentId);
      emit(state.copyWith(wards: wards, status: AddressStatus.getWardsSuccess));
    } catch (e) {
      emit(state.copyWith(status: AddressStatus.getWardsError));
    }
  }

  FutureOr<void> _getDistrictsEvent(GetDistrictsEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AddressStatus.getDistrictsInit));
    try {
      List<Address> districts = await locationUseCase.getAddress(page: 1, pageSize: 200, locationType: LocationEnum.district.name, parentId: event.parentId);
      emit(state.copyWith(districts: districts, status: AddressStatus.getDistrictsSuccess));
    } catch (e) {
      emit(state.copyWith(status: AddressStatus.getDistrictsError));
    }
  }
}
