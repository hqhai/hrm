import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/item_list_over_time.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/item_list_over_time_extend.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeOverTime extends StatefulWidget {
  const RequisitionInformationContentTypeOverTime({
    super.key,
  });

  @override
  State<RequisitionInformationContentTypeOverTime> createState() =>
      _RequisitionInformationContentTypeOverTimeState();
}

class _RequisitionInformationContentTypeOverTimeState
    extends State<RequisitionInformationContentTypeOverTime> {
  List<bool> listCheck = [];

  @override
  void initState() {
    /*if (dI<RequisitionBloc>().state.requisition.config.overTimes?.isNotEmpty ?? false) {
      final int count = dI<RequisitionBloc>().state.requisition.config.overTimes!.length;
      listCheck = List.filled(count, true);
    }*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<RequisitionBloc, RequisitionState>(
      listener: (context, state) => _listener(state),
      listenWhen: (previous, current) => previous.requisition != current.requisition,
      builder: (context, state) {
        final overTimes = state.requisition.config.overTimes;
        final listCheck = List.filled(state.requisition.config.overTimes?.length??0, true);
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
                                            state.requisition.config.overTimes?[index],
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
                  : const SizedBox()
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
}
