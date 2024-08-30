import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ButtonTimekeepingItem extends StatelessWidget {
  const ButtonTimekeepingItem(
      {super.key,
      required this.callBackHistoryTimekeeping,
      required this.callBackTimekeeping,
      required this.checkClick});

  final VoidCallback callBackHistoryTimekeeping;
  final VoidCallback callBackTimekeeping;
  final bool checkClick;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ScheduleSchoolBloc, ScheduleSchoolState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(
              left: SpacingUnit.x4,
              right: SpacingUnit.x4,
              top: SpacingUnit.x3,
              bottom: SpacingUnit.x4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(SpacingUnit.x6),
              topRight: Radius.circular(SpacingUnit.x6),
            ),
            color: colors.background,
            border: Border.all(
              color: colors.background,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              AppButton(
                title: appLocalizations.historyTimekeeping,
                onSubmit: () => callBackHistoryTimekeeping.call(),
                color: colors.background,
                colorText: colors.primary,
              ),
              const SizedBox(
                height: SpacingUnit.x2,
              ),
              AppButton(
                title: appLocalizations.timekeepingImmediately,
                colorText: checkClick ? colors.background : colors.text.withOpacity(0.7),
                color: checkClick ? colors.primary : colors.text.withOpacity(0.2),
                onSubmit: () => callBackTimekeeping.call(),
              ),
            ],
          ),
        );
      },
    );
  }
}
