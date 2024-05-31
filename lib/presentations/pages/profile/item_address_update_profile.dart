import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/address/address_bloc.dart';
import 'package:base_app/presentations/bloc/location/address/address_event.dart';
import 'package:base_app/presentations/bloc/location/address/address_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemAddressUpdateProfile extends StatefulWidget {
  const ItemAddressUpdateProfile({
    super.key,
    required this.onChangeProvince,
    required this.onChangeDistrict,
    required this.onChangeWard,
  });

  final ValueChanged<Address> onChangeProvince, onChangeDistrict, onChangeWard;

  @override
  State<ItemAddressUpdateProfile> createState() => _ItemAddressUpdateProfileState();
}

class _ItemAddressUpdateProfileState extends State<ItemAddressUpdateProfile> {
  String? provinceId, districtId, wardId;

  @override
  void initState() {
    super.initState();
    dI<AddressBloc>().add(const GetProvincesEvent());
    _getGetDistrictsInit();
    _getWardInit();
  }

  _getGetDistrictsInit() {
    String parentId1 = dI<UserBloc>().state.user.residentProvinceId ?? "";
    if (parentId1 != "") {
      dI<AddressBloc>().add(GetDistrictsEvent(parentId: parentId1));
    }
  }

  _getWardInit() {
    String parentId2 = dI<UserBloc>().state.user.residentDistrictId ?? "";
    if (parentId2 != "") {
      dI<AddressBloc>().add(GetWardsEvent(parentId: parentId2));
    }
  }

  _listener(BuildContext context, AddressState state) {
    if (state.status == AddressStatus.getProvincesSuccess && provinceId != '') {
      dI<AddressBloc>().add(GetDistrictsEvent(parentId: provinceId ?? ""));
    }
    if (state.status == AddressStatus.getDistrictsSuccess && districtId != '') {
      dI<AddressBloc>().add(GetWardsEvent(parentId: districtId ?? ""));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, stateUser) {
        return BlocConsumer<AddressBloc, AddressState>(
          listener: (context, state) => _listener(context, state),
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.province,
                  style: TextStyle(color: colors.tertiary, fontSize: SpacingUnit.x4),
                ),
                const SizedBox(
                  height: SpacingUnit.x3,
                ),
                DropdownMenu<Address>(
                  width: width * 0.8,
                  textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                  initialSelection: _checkProvinceUse(state, stateUser),
                  onSelected: (Address? value) => _setProvinceId(
                    value,
                    state,
                    stateUser,
                  ),
                  menuHeight: SpacingUnit.x50,
                  dropdownMenuEntries: state.provinces
                      .map((e) => e)
                      .map((Address value) =>
                          DropdownMenuEntry<Address>(value: value, label: value.name??""))
                      .toList(),
                ),
                const SizedBox(
                  height: SpacingUnit.x3,
                ),
                Text(
                  appLocalizations.district,
                  style: TextStyle(color: colors.tertiary, fontSize: SpacingUnit.x4),
                ),
                const SizedBox(
                  height: SpacingUnit.x3,
                ),
                DropdownMenu<Address>(
                  width: width * 0.8,
                  textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                  initialSelection: _checkDistrictUse(state, stateUser),
                  onSelected: (Address? value) => _setDistrictsId(value, state, stateUser),
                  menuHeight: SpacingUnit.x50,
                  dropdownMenuEntries: state.districts
                      .map((e) => e)
                      .map((Address value) =>
                          DropdownMenuEntry<Address>(value: value, label: value.name??""))
                      .toList(),
                ),
                const SizedBox(
                  height: SpacingUnit.x3,
                ),
                Text(
                  appLocalizations.ward,
                  style: TextStyle(color: colors.tertiary, fontSize: SpacingUnit.x4),
                ),
                const SizedBox(
                  height: SpacingUnit.x3,
                ),
                DropdownMenu<Address>(
                  width: width * 0.8,
                  textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                  initialSelection: _checkWardsUse(state, stateUser),
                  onSelected: (Address? value) => _setOnChangeWard(value, state, stateUser),
                  menuHeight: SpacingUnit.x50,
                  dropdownMenuEntries: state.wards
                      .map((e) => e)
                      .map((Address value) =>
                          DropdownMenuEntry<Address>(value: value, label: value.name??""))
                      .toList(),
                ),
                const SizedBox(
                  height: SpacingUnit.x3,
                ),
              ],
            );
          },
        );
      },
    );
  }

  _setProvinceId(Address? value, AddressState state, UserState stateUser) {
    Address address = Address(
        id: stateUser.user.residentProvinceId, name: stateUser.user.residentProvince);
    widget.onChangeProvince.call(value ?? address);

    setState(() {
      provinceId = state.provinces.where((e) => e.name == value?.name).first.id;
    });
    dI<AddressBloc>().add(GetDistrictsEvent(parentId: provinceId ?? ""));
  }

  _setDistrictsId(Address? value, AddressState state, UserState stateUser) {
    Address address = Address(
        id: stateUser.user.residentDistrictId, name: stateUser.user.residentDistrict);

    widget.onChangeDistrict.call(value ?? address);
    setState(() {
      districtId = state.districts.where((e) => e.name == value?.name).first.id;
    });
    dI<AddressBloc>().add(GetWardsEvent(parentId: districtId ?? ""));
  }

  _setOnChangeWard(Address? value, AddressState state, UserState stateUser) {
    Address address =
        Address(id: stateUser.user.residentWardId, name: stateUser.user.residentWard);
    widget.onChangeWard.call(value ?? address);
  }

  Address _checkProvinceUse(AddressState state, UserState stateUser) {
    if (state.provinces.isNotEmpty) {
      List<Address> addresses =
          state.provinces.where((e) => e.name == stateUser.user.residentProvince).toList();
      if (addresses.isNotEmpty) {
        return addresses[0];
      } else {
        return const Address();
      }
    } else {
      return const Address();
    }
  }

  Address _checkDistrictUse(AddressState state, UserState stateUser) {
    if (state.districts.isNotEmpty) {
      List<Address> addresses =
          state.districts.where((e) => e.name == stateUser.user.residentDistrict).toList();
      if (addresses.isNotEmpty) {
        return addresses[0];
      } else {
        return const Address();
      }
    } else {
      return const Address();
    }
  }

  Address _checkWardsUse(AddressState state, UserState stateUser) {
    if (state.wards.isNotEmpty) {
      List<Address> addresses =
          state.wards.where((e) => e.name == stateUser.user.residentWard).toList();
      if (addresses.isNotEmpty) {
        return addresses[0];
      } else {
        return const Address();
      }
    } else {
      return const Address();
    }
  }
}
