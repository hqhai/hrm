import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_title_value.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationGeneraliInformation extends StatefulWidget {
  const RequisitionInformationGeneraliInformation({super.key, this.checkUser = false});

  final bool checkUser;

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
                      RequestInformationTitleValue(
                        title: appLocalizations.type,
                        value: stateFlow.flow.flowType?.configTypeName ?? "",
                      ),
                      RequestInformationTitleValue(
                        title: appLocalizations.status,
                        value: state.requisition.status.configRequestStatusName,
                      ),
                      RequestInformationTitleValue(
                        title: appLocalizations.applicationCode,
                        value: state.requisition.code,
                      ),
                      RequestInformationTitleValue(
                        title: appLocalizations.createTime,
                        value: formatYMDHMS(
                          dateTimeLocal(state.requisition.createdDate).toString(),
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

  bool checkNote(StatusRequestEnum status) {
    return status == StatusRequestEnum.edit ||
        status == StatusRequestEnum.reject ||
        status == StatusRequestEnum.approve;
  }

  EnumStepRequestStatusEnum? setStatus(StatusRequestEnum status) {
    final index =
        EnumStepRequestStatusEnum.values.indexWhere((element) => element.name == status.name);
    if (index != -1) {
      return EnumStepRequestStatusEnum.values[index];
    }
    return null;
  }
}
