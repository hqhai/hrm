import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/explanation.dart';
import 'package:base_app/domain/entities/requisition/work_shift_registered_details.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_event.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_state.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/item/item_work_shift_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class BottomSheetWorkShiftWidget extends StatefulWidget {
  const BottomSheetWorkShiftWidget({
    super.key,
    required this.onChange,
    this.explanations = const [],
  });

  final ValueChanged<Explanation> onChange;
  final List<Explanation> explanations;

  @override
  State<BottomSheetWorkShiftWidget> createState() =>
      _BottomSheetWorkShiftWidgetState();
}

class _BottomSheetWorkShiftWidgetState
    extends State<BottomSheetWorkShiftWidget> {
  @override
  void initState() {
    dI<LeaveShiftBloc>().add(const GetWorkShiftsExplanationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<LeaveShiftBloc, LeaveShiftState>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(SpacingUnit.x4),
                child: Text(
                  appLocalizations.chooseWorkShift,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.keys.length,
                  itemBuilder: (context, index) {
                    final date =
                        DateTime.fromMicrosecondsSinceEpoch(state.keys[index]);
                    final workShift = state.mapKeyDate[state.keys[index]]
                            ?.map(
                              (e) =>
                                  state.workShifts[e] ??
                                  WorkShiftRegisteredDetail(
                                    workDate: DateTime.now(),
                                  ),
                            )
                            .toList() ??
                        [];
                    final explanations = workShift
                        .map(
                          (e) => Explanation(
                            workDate: e.workDate,
                            checkIn: e.endTime,
                            note: '',
                            checkOut: e.startTime,
                          ),
                        )
                        .toList();
                    return ItemSheetWorkShiftBSWidget(
                      selectExplanations: widget.explanations,
                      setExplanation: (value) => setOnChange(
                        context: context,
                        explanation: value,
                      ),
                      explanations: explanations,
                      index: index,
                      value: formatYMD(date.toString()),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  setOnChange({
    required BuildContext context,
    required Explanation explanation,
  }) {
    widget.onChange.call(explanation);
    dI<AppNavigation>().pop(context);
  }
}
