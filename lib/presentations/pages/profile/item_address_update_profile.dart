import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_district.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_province.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_ward.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemAddressUpdateProfile extends StatefulWidget {
  const ItemAddressUpdateProfile({
    super.key,
    required this.onChangeProvince,
    required this.onChangeDistrict,
    required this.onChangeWard,
    this.district = const Address(),
    this.ward = const Address(),
    this.province = const Address(),
  });

  final ValueChanged<Address> onChangeProvince, onChangeDistrict, onChangeWard;
  final Address province, district, ward;

  @override
  State<ItemAddressUpdateProfile> createState() => _ItemAddressUpdateProfileState();
}

class _ItemAddressUpdateProfileState extends State<ItemAddressUpdateProfile> {
  Address? province, district, ward;

  @override
  void initState() {
    province = widget.province;
    district = widget.district;
    ward = widget.ward;
    super.initState();
  }

  _getProvince(Address address) {
    setState(() {
      province = address;
      widget.onChangeProvince.call(address);
    });
  }

  _getDistrict(Address address) {
    setState(() {
      district = address;
      widget.onChangeDistrict.call(address);
    });
  }

  _getWard(Address address) {
    setState(() {
      ward = address;
      widget.onChangeWard.call(address);
    });
  }

  _addProvince(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetProvinceWidget(
          onChange: (value) => _getProvince(value),
        );
      },
    );
  }

  _addDistrict(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetDistrictWidget(
          parentId: province?.id ?? "",
          onChange: (value) => _getDistrict(value),
        );
      },
    );
  }

  _addWard(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetWardWidget(
          parentId: district?.id ?? "",
          onChange: (value) => _getWard(value),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, stateUser) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item(
              title: appLocalizations.province,
              value: province?.name ?? "",
              context: context,
              callback: () => _addProvince(context),
            ),
            const SizedBox(
              height: SpacingUnit.x4,
            ),
            item(
              title: appLocalizations.district,
              value: district?.name ?? "",
              context: context,
              callback: () => _addDistrict(context),
            ),
            const SizedBox(
              height: SpacingUnit.x4,
            ),
            item(
              title: appLocalizations.ward,
              value: ward?.name ?? "",
              context: context,
              callback: () => _addWard(context),
            ),
          ],
        );
      },
    );
  }

  Widget item(
      {required BuildContext context,
      required String title,
      required String value,
      required VoidCallback callback}) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w600,
          ),
        ),
        ContainerBorder(
          borderColors: colors.surfaceBright.withOpacity(0.6),
          marginTop: SpacingUnit.x2,
          paddingVertical: SpacingUnit.x4,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
              InkWell(
                onTap: () => callback.call(),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: colors.text,
                  size: SpacingUnit.x6,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
