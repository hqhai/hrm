import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/data/models/location/get_location_response.dart';
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
    on<GetDistrictsByKeyEvent>(_getDistrictsByKeyEvent);
    on<GetWardsByKeyEvent>(_getWardsByKeyEvent);
    on<GetProvinceByKeyEvent>(_getProvinceByKeyEvent);
  }

  FutureOr<void> _getProvincesEvent(GetProvincesEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AddressStatus.init));
    try {
      List<Address> provinces = [];
      GetLocationResponse newProvinces = await locationUseCase.getAddress(
          page: event.page, pageSize: 10, locationType: LocationEnum.province.name);
      if (event.page > 1) {
        provinces.addAll(state.provinces);
        provinces.addAll(newProvinces.items);
        emit(state.copyWith(
            provinces: provinces,
            totalItemProvinces: newProvinces.pagingInfo.totalItems,
            status: AddressStatus.getProvincesSuccess));
      } else {
        provinces.addAll(newProvinces.items);
        emit(state.copyWith(
            provinces: provinces,
            totalItemProvinces: newProvinces.pagingInfo.totalItems,
            status: AddressStatus.getProvincesSuccess));
      }
    } catch (e) {
      emit(state.copyWith(status: AddressStatus.fail));
    }
  }

  FutureOr<void> _getWardsEvent(GetWardsEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AddressStatus.init));
    try {
      List<Address> wards = [];
      GetLocationResponse newWards = await locationUseCase.getAddress(
        page: event.page,
        pageSize: 10,
        locationType: LocationEnum.ward.name,
        parentId: event.parentId,
      );
      if (event.page > 1) {
        wards.addAll(state.wards);
        wards.addAll(newWards.items);
        emit(state.copyWith(
            wards: wards,
            totalItemWards: newWards.pagingInfo.totalItems,
            status: AddressStatus.getWardsSuccess));
      } else {
        wards.addAll(newWards.items);
        emit(state.copyWith(
            wards: wards,
            totalItemWards: newWards.pagingInfo.totalItems,
            status: AddressStatus.getWardsSuccess));
      }
    } catch (e) {
      emit(state.copyWith(status: AddressStatus.fail));
    }
  }

  FutureOr<void> _getDistrictsEvent(GetDistrictsEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AddressStatus.init));
    try {
      List<Address> districts = [];
      GetLocationResponse newDistricts = await locationUseCase.getAddress(
          page: event.page,
          pageSize: 10,
          locationType: LocationEnum.district.name,
          parentId: event.parentId);
      if (event.page > 1) {
        districts.addAll(state.districts);
        districts.addAll(newDistricts.items);
        emit(state.copyWith(
            districts: districts,
            totalItemDistricts: newDistricts.pagingInfo.totalItems,
            status: AddressStatus.getDistrictsSuccess));
      } else {
        districts.addAll(newDistricts.items);
        emit(state.copyWith(
            districts: districts,
            totalItemDistricts: newDistricts.pagingInfo.totalItems,
            status: AddressStatus.getDistrictsSuccess));
      }
      emit(state.copyWith(districts: districts, status: AddressStatus.getDistrictsSuccess));
    } catch (e) {
      emit(state.copyWith(status: AddressStatus.fail));
    }
  }

  FutureOr<void> _getDistrictsByKeyEvent(
      GetDistrictsByKeyEvent event, Emitter<AddressState> emit) async {
    /*emit(state.copyWith(status: AddressStatus.getDistrictsByKeyInit));
    try {
      List<Address> districts = await locationUseCase.getAddress(
          page: 1,
          pageSize: numberOfDistrict,
          locationType: LocationEnum.district.name,
          keyWord: event.keyWord);
      emit(state.copyWith(districts: districts, status: AddressStatus.getDistrictsByKeySuccess));
    } catch (e) {
      emit(state.copyWith(status: AddressStatus.getDistrictsByKeyError));
    }*/
  }

  FutureOr<void> _getWardsByKeyEvent(GetWardsByKeyEvent event, Emitter<AddressState> emit) async {
    /*emit(state.copyWith(status: AddressStatus.getWardsByKeyInit));
    try {
      List<Address> wards = await locationUseCase.getAddress(
          page: 1,
          pageSize: numberOfWards,
          locationType: LocationEnum.ward.name,
          keyWord: event.keyWord);
      emit(state.copyWith(wards: wards, status: AddressStatus.getWardsByKeySuccess));
    } catch (e) {
      emit(state.copyWith(status: AddressStatus.getWardsByKeyError));
    }*/
  }

  FutureOr<void> _getProvinceByKeyEvent(
      GetProvinceByKeyEvent event, Emitter<AddressState> emit) async {
    /*emit(state.copyWith(status: AddressStatus.getProvinceByKeySuccess));
    try {
      List<Address> province = await locationUseCase.getAddress(
          page: 1,
          pageSize: numberOfProvinces,
          locationType: LocationEnum.province.name,
          keyWord: event.keyWord);
      emit(state.copyWith(provinces: province, status: AddressStatus.getProvinceByKeySuccess));
    } catch (e) {
      emit(state.copyWith(status: AddressStatus.getProvinceByKeyError));
    }*/
  }
}
