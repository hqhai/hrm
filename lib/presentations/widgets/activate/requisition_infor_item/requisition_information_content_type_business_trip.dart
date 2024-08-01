import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_person_information_request.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeBusinessTrip extends StatefulWidget {
  const RequisitionInformationContentTypeBusinessTrip({
    super.key,
  });

  @override
  State<RequisitionInformationContentTypeBusinessTrip> createState() =>
      _RequisitionInformationContentTypeBusinessTripState();
}

class _RequisitionInformationContentTypeBusinessTripState
    extends State<RequisitionInformationContentTypeBusinessTrip> {
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
                      fontSize: SpacingUnit.x4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ItemTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.startTime,
                    value: formatYMDHMS(
                      (state.requisition.config.startDate ?? "").toString(),
                    ),
                  ),
                  ItemTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.endTime,
                    value: formatYMDHMS((state.requisition.config.endDate ?? "").toString()),
                  ),
                  ItemTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.totalDays,
                    value: (state.requisition.config.total ?? 0).toStringAsFixed(3),
                  ),
                 if (state.requisition.config.subtitudePersons?.isNotEmpty ?? false)
                    ItemPersonInformationRequest(
                      title: appLocalizations.accompanyingPerson,
                    ),
                  ItemTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.vehicle,
                    value: state.requisition.config.vehicle ?? "",
                  ),
                  ItemTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.description,
                    value: state.requisition.config.content ?? "",
                  ),
                  Text(
                    appLocalizations.workingContent,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
                    child: ContainerBorder(
                      width: width,
                      borderColors: colors.text.withOpacity(0.2),
                      child: Text(
                        state.requisition.config.content ?? "",
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4,
                        ),
                      ),
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
