import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/shift/shift_bloc.dart';
import 'package:base_app/presentations/bloc/shift/shift_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ReasonWorkDayDetail extends StatefulWidget {
  final TextEditingController reasonController;
  final String data;
  final WorkShiftRequestStatus status;

  const ReasonWorkDayDetail({
    super.key,
    required this.reasonController,
    required this.data,
    required this.status,
  });

  @override
  State<ReasonWorkDayDetail> createState() => _ReasonWorkDayDetailState();
}

class _ReasonWorkDayDetailState extends State<ReasonWorkDayDetail> {
  @override
  void initState() {
    widget.reasonController.text = widget.data;
    super.initState();
  }

  bool enabled() {
    return widget.status == WorkShiftRequestStatus.approve;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ShiftBloc, ShiftState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
              child: Text(
                _getTextReason(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: SpacingUnit.x4,
                  color: colors.text,
                ),
              ),
            ),
            Text(
              state.shift.workShiftApproves.isNotEmpty
                  ? state.shift.workShiftApproves.first.content
                  : '',
              style: TextStyle(
                fontSize: SpacingUnit.x3,
                color: colors.text,
              ),
            ),
            TextField(
              enabled: enabled(),
              controller: widget.reasonController,
              maxLines: 7,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.outline,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.outline),
                ),
                suffixStyle: const TextStyle(color: Colors.green),
                hintText: appLocalizations.enterReason,
              ),
            ),
          ],
        );
      },
    );
  }

  String _getTextReason() {
    final appLocalizations = AppLocalizations.of(context)!;
    if (widget.status == WorkShiftRequestStatus.approve) {
      return appLocalizations.reasonForCancelingRequest;
    } else if (widget.status == WorkShiftRequestStatus.cancel) {
      return appLocalizations.reasonForCanceling;
    } else if (widget.status == WorkShiftRequestStatus.reject) {
      return appLocalizations.reasonForRejection;
    }

    return '';
  }
}
