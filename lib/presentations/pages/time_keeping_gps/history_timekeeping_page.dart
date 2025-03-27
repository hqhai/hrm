import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_state.dart';
import 'package:base_app/presentations/pages/attendance/tab/item_shift_on_tab.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final timekeepingGPSHistoryRoute = GoRoute(
    path: Pages.timekeepingGPSSHistory,
    name: Pages.timekeepingGPSSHistory,
    builder: (context, GoRouterState state) {
      return const HistoryTimekeepingPage();
    });

class HistoryTimekeepingPage extends StatelessWidget {
  const HistoryTimekeepingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        centerTitle: true,
        title: Text(
          appLocalizations.historyTimekeeping,
          style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4_5,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<WorkSheetBloc, WorkSheetState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
                right: SpacingUnit.x4,
                left: SpacingUnit.x4,
                top: SpacingUnit.x4),
            child: SizedBox(
              width: width,
              child: Column(
                mainAxisAlignment: state.keys.isNotEmpty
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                crossAxisAlignment: state.keys.isNotEmpty
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                children: [
                  if (state.keys.isEmpty) ...[
                    Image.asset(
                      Assets.images.timeKeeping.timekeeping.path,
                      width: SpacingUnit.x65,
                      height: SpacingUnit.x59,
                    ),
                    const SizedBox(
                      height: SpacingUnit.x6,
                    ),
                    Text(
                      appLocalizations.noDataTimekeeping,
                      style: TextStyle(
                        color: colors.text.withValues(alpha: 0.7),
                        fontSize: SpacingUnit.x4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: SpacingUnit.x15,
                        left: SpacingUnit.x15,
                        top: SpacingUnit.x6,
                      ),
                      child: AppButton(
                        title: appLocalizations.timekeepingImmediately,
                        color: colors.blue.withValues(alpha: 0.4),
                        colorText: colors.primary,
                        onSubmit: () => _onSubmit(context),
                      ),
                    )
                  ],
                  if (state.keys.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: SpacingUnit.x6),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: state.keys.mapIndexed((index, element) {
                              final attendance = state.attendances[element];
                              return ItemShiftOnTab(
                                title: appLocalizations.checkIn,
                                value: formatHM(
                                    attendance?.timeChecking.toString()),
                                checkInMethodEnum: attendance?.checkInMethod ??
                                    CheckInMethodEnum.gPS,
                                last: element != state.keys.last,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onSubmit(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }
}
