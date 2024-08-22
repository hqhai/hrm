import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/shift/shift_bloc.dart';
import 'package:base_app/presentations/bloc/shift/shift_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ShiftReasonWidget extends StatelessWidget {
  const ShiftReasonWidget({super.key, required this.reasonController});

  final TextEditingController reasonController;

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
              state.shift.workShiftApprove.note,
              style: TextStyle(
                fontSize: SpacingUnit.x3,
                color: colors.text,
              ),
            ),
            TextField(
              controller: reasonController,
              maxLines: 11,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: colors.outline)),
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
