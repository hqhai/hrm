import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_person_information_request.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeVehicleDispatch extends StatelessWidget {
  const RequisitionInformationContentTypeVehicleDispatch({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
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
                    value: formatYMDHMS((state.requisition.config.startDate ?? "").toString()),
                  ),
                  ItemTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.endTime,
                    value: formatYMDHMS((state.requisition.config.endDate ?? "").toString()),
                  ),
                  ItemTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.schedule,
                    value: state.requisition.config.description,
                  ),
                  if (state.requisition.config.subtitudePersons.isNotEmpty)
                    ItemPersonInformationRequest(
                      title: appLocalizations.accompanyingPerson,
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
