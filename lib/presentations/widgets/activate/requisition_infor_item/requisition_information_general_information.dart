import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationGeneraliInformation extends StatefulWidget {
  const RequisitionInformationGeneraliInformation({
    super.key,
    this.followerIds = const [],
  });

  final List<String> followerIds;

  @override
  State<RequisitionInformationGeneraliInformation> createState() =>
      _RequisitionInformationGeneraliInformationState();
}

class _RequisitionInformationGeneraliInformationState
    extends State<RequisitionInformationGeneraliInformation> {
  @override
  void initState() {
    dI<UserByIdBloc>().add(GetUsersByIdEvent(ids: widget.followerIds));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<FlowBloc, FlowState>(
      builder: (context, stateFlow) {
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
                        appLocalizations.generalInformation,
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
                            Text(appLocalizations.type,
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                            Text(stateFlow.flow.flowType?.configTypeName ?? "",
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(appLocalizations.status,
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                            Text(state.requisition.status.configRequestStatusName,
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(appLocalizations.applicationCode,
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                            Text(state.requisition.code,
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(appLocalizations.createTime,
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                            Text(formatYMDHMS(state.requisition.createdDate),
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appLocalizations.follower,
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                            const SizedBox(height: SpacingUnit.x2),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: stateUserById.userById
                                    .mapIndexed(
                                      (index, element) => Text(
                                        stateUserById.userById[index].fullName,
                                        style:
                                            TextStyle(color: colors.blue, fontSize: SpacingUnit.x3),
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
