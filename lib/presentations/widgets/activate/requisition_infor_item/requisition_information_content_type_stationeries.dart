import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_list_stationeries.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_list_stationeries_extend.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeStationeries extends StatefulWidget {
  const RequisitionInformationContentTypeStationeries({
    super.key,
  });

  @override
  State<RequisitionInformationContentTypeStationeries> createState() =>
      _RequisitionInformationContentTypeStationeriesState();
}

class _RequisitionInformationContentTypeStationeriesState
    extends State<RequisitionInformationContentTypeStationeries> {
  List<bool> listCheck = [];

  @override
  void initState() {
    if (dI<RequisitionBloc>().state.requisition.config.stationeries?.isNotEmpty ?? false) {
      int count = dI<RequisitionBloc>().state.requisition.config.stationeries!.length;
      listCheck = List.filled(count, true);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.description,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x3,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (state.requisition.config.stationeries?.isNotEmpty ?? false)
                Container(
                  padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                  child: Column(
                    children: state.requisition.config.stationeries!
                        .mapIndexed(
                          (index, element) => listCheck[index]
                              ? GestureDetector(
                                  onTap: () => onClick(index),
                                  child: ItemListStationeries(
                                    stationeries: state.requisition.config.stationeries?[index],
                                    index: index,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => onClick(index),
                                  child: ItemListStationeriesExtend(
                                    stationeries: state.requisition.config.stationeries?[index],
                                    index: index,
                                  ),
                                ),
                        )
                        .toList(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  checkSubmit(int index) {
    setState(() {
      listCheck[index] = !listCheck[index];
    });
  }

  onClick(int index) {
    setState(() {
      listCheck[index] = !listCheck[index];
    });
  }
}
