import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_list_stationeries_extend.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value.dart';
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
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(state),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTitleValue(
                size: SpacingUnit.x4,
                title: appLocalizations.month,
                value: monthTime(state.requisition.config.startDate),
                font: FontWeight.w600,
              ),
              Text(
                appLocalizations.description,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (state.requisition.config.stationeries?.isNotEmpty ?? false)
                Container(
                  padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                  child: Column(
                    children: state.requisition.config.stationeries!
                        .mapIndexed(
                          (index, element) => ItemListStationeriesExtend(
                            stationeries: state.requisition.config.stationeries?[index],
                            index: index,
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

  String monthTime(DateTime? date) {
    return formatYM(
      date?.year ?? DateTime.now().year,
      date?.month ?? DateTime.now().month,
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

  _listener(RequisitionState state) {
    setState(() {
      final int count = state.requisition.config.stationeries!.length;
      listCheck = List.filled(count, true);
    });
  }
}
