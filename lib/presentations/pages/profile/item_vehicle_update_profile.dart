import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/vehicle_bottom_sheet.dart';
import 'package:flutter/material.dart';
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
  VehicleTypeEnum vehicle = VehicleTypeEnum.motorbike;

  @override
  void initState() {
    vehicle = widget.vehicle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.vehicleType,
          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
        ),
        ContainerBorder(
          borderColors: colors.surfaceBright.withOpacity(0.6),
          paddingVertical: SpacingUnit.x4,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                vehicle.configVehicleTypeName,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
              InkWell(
                onTap: () => _showBottomSheet(
                  context,
                ),
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

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return VehicleBottomSheetWidget(
          vehicle: vehicle,
          onChange: (value) => _setVehicle(value),
        );
      },
    );
  }

  _setVehicle(VehicleTypeEnum value) {
    setState(() {
      vehicle = value;
    });
    widget.onChangeVehicle.call(value);
  }
}
