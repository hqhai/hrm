import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/requisition_vehicle_dispatch.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeVehicleDispatch extends StatelessWidget {
  const RequisitionInformationContentTypeVehicleDispatch(
      {super.key, this.requisitionVehicleDispatch = const RequisitionVehicleDispatch()});

  final RequisitionVehicleDispatch requisitionVehicleDispatch;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.contentOfApplication,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x3,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.drivingTime,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(requisitionVehicleDispatch.startTime ?? "",
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.startTime,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(requisitionVehicleDispatch.startTime ?? "",
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.endTime,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(requisitionVehicleDispatch.endTime ?? "",
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.drive,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(requisitionVehicleDispatch.drive ?? "",
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2, bottom: SpacingUnit.x4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.carCaller,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(requisitionVehicleDispatch.carCaller ?? "",
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Text(
            appLocalizations.schedule,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x3,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2, bottom: SpacingUnit.x3),
            child: Text(
              requisitionVehicleDispatch.schedule ?? "",
              maxLines: 10,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
          Text(
            appLocalizations.reasonForDriving,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x3,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Text(
              requisitionVehicleDispatch.reasonForCallingACar ?? "",
              maxLines: 10,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
