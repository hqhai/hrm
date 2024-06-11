import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemVehicleUpdateProfile extends StatefulWidget {
  const ItemVehicleUpdateProfile({
    super.key,
    this.vehicle = VehicleTypeEnum.car,
    required this.onChangeVehicle,
  });

  final ValueChanged<VehicleTypeEnum> onChangeVehicle;
  final VehicleTypeEnum vehicle;

  @override
  State<ItemVehicleUpdateProfile> createState() =>
      _ItemVehicleUpdateProfileState();
}

class _ItemVehicleUpdateProfileState extends State<ItemVehicleUpdateProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.vehicleType,
              style: TextStyle(color: colors.tertiary, fontSize: SpacingUnit.x4),
            ),
            const SizedBox(
              height: SpacingUnit.x3,
            ),
            DropdownMenu<VehicleTypeEnum>(
              textStyle: const TextStyle(fontSize: SpacingUnit.x3),
              initialSelection: widget.vehicle,
              onSelected: (VehicleTypeEnum? value) => _setGender(value),
              dropdownMenuEntries:
                  VehicleTypeEnum.values.map<DropdownMenuEntry<VehicleTypeEnum>>((VehicleTypeEnum value) {
                return DropdownMenuEntry<VehicleTypeEnum>(
                    value: value,
                    label: value.configVehicleTypeName);
              }).toList(),
            ),
            const SizedBox(
              height: SpacingUnit.x3,
            ),
          ],
        );
      },
    );
  }

  _setGender(VehicleTypeEnum? value) {
    widget.onChangeVehicle.call(value??VehicleTypeEnum.car);
  }
}
