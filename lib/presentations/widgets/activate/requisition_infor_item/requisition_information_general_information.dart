import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_title_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationGeneraliInformation extends StatefulWidget {
  const RequisitionInformationGeneraliInformation({
    super.key,
  });

  @override
  State<RequisitionInformationGeneraliInformation> createState() =>
      _RequisitionInformationGeneraliInformationState();
}

class _RequisitionInformationGeneraliInformationState
    extends State<RequisitionInformationGeneraliInformation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<FlowBloc, FlowState>(
      builder: (context, stateFlow) {
        return BlocBuilder<RequisitionBloc, RequisitionState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.generalInformation,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  RequestInformationTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.type,
                    value: stateFlow.flow.flowType?.configTypeName ?? "",
                  ),
                  RequestInformationTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.status,
                    value: state.requisition.status.getAppLocalizationName,
                  ),
                  RequestInformationTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.createTime,
                    value: formatYMDHMS(
                      dateTimeLocal(state.requisition.createdDate).toString(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
