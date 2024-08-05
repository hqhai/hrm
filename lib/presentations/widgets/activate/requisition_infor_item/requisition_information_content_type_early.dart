import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/item_list_over_time.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/item_list_over_time_extend.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeEarly extends StatefulWidget {
  const RequisitionInformationContentTypeEarly({
    super.key,
  });

  @override
  State<RequisitionInformationContentTypeEarly> createState() =>
      _RequisitionInformationContentTypeEarlyState();
}

class _RequisitionInformationContentTypeEarlyState
    extends State<RequisitionInformationContentTypeEarly> {
  List<bool> listCheck = [];

  @override
  void initState() {
    final Request request = dI<RequisitionBloc>().state.requisition;
    listCheck = List.filled(request.config.overTimes?.length ?? 0, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(state),
      listenWhen: (previous, current) => previous.requisition != current.requisition,
      buildWhen: (previous, current) => buildWhen(
        previous.requisition,
        current.requisition,
      ),
      builder: (context, state) {
        final overTimes = state.requisition.config.overTimes;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTitleValue(
                size: SpacingUnit.x4,
                title: appLocalizations.time,
                value: formatYMD((state.requisition.config.startDate ?? "").toString()),
                font: FontWeight.w600,
              ),
              ItemTitleValue(
                size: SpacingUnit.x4,
                title: appLocalizations.reason,
                value: state.requisition.config.explanationReason?.configEditTimekeepingName ?? "",
                font: FontWeight.w600,
              ),
              if (state.requisition.config.explanationReason == EditTimekeeping.early)
                Text(
                  appLocalizations.workOffset,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (state.requisition.config.explanationReason == EditTimekeeping.early)
                (overTimes != null && overTimes.isNotEmpty)
                    ? Container(
                        padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                        child: Column(
                          children: overTimes
                              .mapIndexed(
                                (index, element) => listCheck[index]
                                    ? GestureDetector(
                                        onTap: () => onClick(index),
                                        child: ItemListOverTime(
                                          requisitionOverTime:
                                              state.requisition.config.overTimes![index],
                                          index: index,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () => onClick(index),
                                        child: ItemListOverTimeExtend(
                                          requisitionOverTime:
                                              state.requisition.config.overTimes?[index],
                                          index: index,
                                        ),
                                      ),
                              )
                              .toList(),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                        child: Text(
                          appLocalizations.no,
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
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

  _listener(RequisitionState state) {
    setState(() {
      final int count = state.requisition.config.overTimes!.length;
      listCheck = List.filled(count, true);
    });
  }

  buildWhen(Request requisition, Request requisition2) {
    final check = requisition != requisition2;
    return check;
  }
}
