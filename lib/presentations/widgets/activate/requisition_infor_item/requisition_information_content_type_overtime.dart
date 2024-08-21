import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/item_list_over_time.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        final overTimes = state.requisition.config.overTimes;
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
                  fontSize: SpacingUnit.x4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              (overTimes != null && overTimes.isNotEmpty)
                  ? Container(
                      padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                      child: Column(
                        children: overTimes
                            .mapIndexed(
                              (index, element) => ItemListOverTime(
                                checkType: RequestType.oT,
                                requisitionOverTime: state.requisition.config.overTimes![index],
                                index: index,
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
}
