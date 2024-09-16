import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/shift/shift_bloc.dart';
import 'package:base_app/presentations/bloc/shift/shift_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ListShiftInTab extends StatelessWidget {
  const ListShiftInTab({super.key});

  List<Shift> shifts({required ShiftState stateShift, required ShiftType type}) {
    return stateShift.keys
        .map((e) => stateShift.mapShift[e] ?? const Shift())
        .where((element) => element.type == type)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<ShiftBloc, ShiftState>(
      builder: (context, stateShift) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (shifts(stateShift: stateShift, type: ShiftType.administrativeShift).isNotEmpty) ...[
              const SizedBox(
                height: SpacingUnit.x2,
              ),
              Text(
                '${appLocalizations.administrativeShift}: ',
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ...shifts(stateShift: stateShift, type: ShiftType.administrativeShift).map(
                (shift) => Padding(
                  padding: const EdgeInsets.only(top: SpacingUnit.x2),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        height: SpacingUnit.x1,
                        width: SpacingUnit.x1,
                        Assets.images.icon.home.worksheet.dot,
                        colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                      ),
                      const SizedBox(
                        width: SpacingUnit.x2,
                      ),
                      Text(
                        '${strSeconds(shift.startTime) ?? ""} - ${strSeconds(shift.endTime) ?? ""}',
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: SpacingUnit.x2,
              ),
            ],
            if (shifts(stateShift: stateShift, type: ShiftType.singleShift).isNotEmpty) ...[
              const SizedBox(
                height: SpacingUnit.x2,
              ),
              Text(
                '${appLocalizations.singleShift}: ',
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ...shifts(stateShift: stateShift, type: ShiftType.singleShift).map(
                (shift) => Padding(
                  padding: const EdgeInsets.only(top: SpacingUnit.x2),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        height: SpacingUnit.x1,
                        width: SpacingUnit.x1,
                        Assets.images.icon.home.worksheet.dot,
                        colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                      ),
                      const SizedBox(
                        width: SpacingUnit.x2,
                      ),
                      Text(
                        '${strSeconds(shift.startTime) ?? ""} - ${strSeconds(shift.endTime) ?? ""}',
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: SpacingUnit.x2,
              ),
            ],
          ],
        );
      },
    );
  }
}
