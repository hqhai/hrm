import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeLeave extends StatefulWidget {
  const RequisitionInformationContentTypeLeave({
    super.key,
  });

  @override
  State<RequisitionInformationContentTypeLeave> createState() =>
      _RequisitionInformationContentTypeLeaveState();
}

class _RequisitionInformationContentTypeLeaveState
    extends State<RequisitionInformationContentTypeLeave> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<UserByIdBloc, UserByIdState>(
      builder: (context, stateUserById) {
        return BlocBuilder<RequisitionBloc, RequisitionState>(
          builder: (context, state) {
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
                  ItemTitleValue(
                    title: appLocalizations.startTime,
                    value: formatYMDHMS(
                      (state.requisition.config.startDate ?? "").toString(),
                    ),
                  ),
                  ItemTitleValue(
                    title: appLocalizations.endTime,
                    value: formatYMDHMS(
                      (state.requisition.config.endDate ?? "").toString(),
                    ),
                  ),
                  ItemTitleValue(
                    title: appLocalizations.totalDays,
                    value: (state.requisition.config.total ?? 0).toString(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: SpacingUnit.x1,
                      top: SpacingUnit.x2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalizations.substitute,
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        if (stateUserById.subtitudePersons.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                            height: SpacingUnit.x6 * stateUserById.subtitudePersons.length,
                            child: ListView.builder(
                              itemCount: stateUserById.subtitudePersons.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x1),
                                child: Text(
                                  stateUserById.subtitudePersons[index].fullName,
                                  style: TextStyle(
                                    color: colors.blue,
                                    fontSize: SpacingUnit.x3,
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalizations.reason,
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          width: width * 0.5,
                          child: Text(
                            state.requisition.config.takeLeaveReason?.configEnumTakeLeaveName ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x3,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ItemTitleValue(
                    title:  appLocalizations.description,
                    value:  state.requisition.config.description ?? "",
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
