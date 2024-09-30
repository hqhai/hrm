import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/shift/shift_bloc.dart';
import 'package:base_app/presentations/bloc/shift/shift_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ShiftReasonWidget extends StatefulWidget {
  const ShiftReasonWidget({super.key, required this.reasonController, required this.data});

  final TextEditingController reasonController;
  final Shift data;

  @override
  State<ShiftReasonWidget> createState() => _ShiftReasonWidgetState();
}

class _ShiftReasonWidgetState extends State<ShiftReasonWidget> {
  @override
  void initState() {
    widget.reasonController.text = content();
    super.initState();
  }

  String content() {
    if (widget.data.workShiftApproves.isEmpty) {
      return '';
    } else {
      widget.data.workShiftApproves.sort(
          (a, b) => (a.createdDate ?? DateTime.now()).compareTo(b.createdDate ?? DateTime.now()));
      return widget.data.workShiftApproves.first.note;
    }
  }

  bool enabled() {
    return content().isEmpty && widget.data.status == WorkShiftRequestStatus.reject;
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
                appLocalizations.reasonForCancelingRequest,
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
                border: OutlineInputBorder(borderSide: BorderSide(color: colors.outline)),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.outline),
                ),
                suffixStyle: const TextStyle(color: Colors.green),
                hintText: "Nhập lý do...",
              ),
            ),
          ],
        );
      },
    );
  }
}
