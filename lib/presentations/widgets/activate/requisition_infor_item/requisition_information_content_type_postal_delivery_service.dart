import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequisitionInformationContentTypePostalDeliveryService extends StatelessWidget {
  const RequisitionInformationContentTypePostalDeliveryService({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return ItemTitleValue(
          size: SpacingUnit.x4,
          title: appLocalizations.transferType,
          value: state.requisition.config.deliveryType ?? "",
          font: FontWeight.w600,
        );
      },
    );
  }
}
