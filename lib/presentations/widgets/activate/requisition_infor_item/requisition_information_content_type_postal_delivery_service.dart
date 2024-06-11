import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/requisition_postal_delivery_service.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypePostalDeliveryService extends StatelessWidget {
  const RequisitionInformationContentTypePostalDeliveryService(
      {super.key, this.requisitionPostalDeliveryService = const RequisitionPostalDeliveryService()});

  final RequisitionPostalDeliveryService requisitionPostalDeliveryService;

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
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2, bottom: SpacingUnit.x3),
            child: Text(
              requisitionPostalDeliveryService.content ?? "",
              maxLines: 10,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
          Text(
            appLocalizations.shippingPurpose,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x3,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Text(
              requisitionPostalDeliveryService.shippingPurpose ?? "",
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
