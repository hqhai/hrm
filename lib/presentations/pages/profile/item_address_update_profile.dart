import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
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
  const ItemAddressUpdateProfile(
      {super.key,
      required this.onChangeProvince,
      required this.onChangeDistrict,
      required this.onChangeWard});

  final ValueChanged<String> onChangeProvince, onChangeDistrict, onChangeWard;

  @override
  State<ItemAddressUpdateProfile> createState() => _ItemAddressUpdateProfileState();
}

class _ItemAddressUpdateProfileState extends State<ItemAddressUpdateProfile> {
  String? provinceId = '', districtId = '', wardId = '';

  @override
  void initState() {
    super.initState();
    dI<AddressBloc>().add(const GetProvincesEvent());
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
                DropdownMenu<String>(
                  width: width*0.8,
                  textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                  initialSelection: stateUser.user.residentProvince,
                  onSelected: (String? value) => _setProvinceId(value, state),
                  menuHeight: SpacingUnit.x50,
                  dropdownMenuEntries: state.provinces
                      .map((e) => e.name)
                      .toList()
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
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
                DropdownMenu<String>(
                  width: width*0.8,
                  textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                  initialSelection: stateUser.user.residentDistrict,
                  onSelected: (String? value) => _setDistrictsId(value, state),
                  menuHeight: SpacingUnit.x50,
                  dropdownMenuEntries: state.districts
                      .map((e) => e.name)
                      .toList()
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
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
                DropdownMenu<String>(
                  width: width*0.8,
                  textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                  initialSelection: stateUser.user.residentWard,
                  onSelected: (String? value) => widget.onChangeWard,
                  menuHeight: SpacingUnit.x50,
                  dropdownMenuEntries: state.wards
                      .map((e) => e.name)
                      .toList()
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
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

  _setProvinceId(String? value, AddressState state) {
    (value) => widget.onChangeProvince;

    setState(() {
      provinceId = state.provinces.where((e) => e.name == value).first.id;
    });
    dI<AddressBloc>().add(GetDistrictsEvent(parentId: provinceId ?? ""));
  }

  _setDistrictsId(String? value, AddressState state) {
    (value) => widget.onChangeDistrict;
    setState(() {
      districtId = state.districts.where((e) => e.name == value).first.id;
    });
    dI<AddressBloc>().add(GetWardsEvent(parentId: districtId ?? ""));
  }
}
