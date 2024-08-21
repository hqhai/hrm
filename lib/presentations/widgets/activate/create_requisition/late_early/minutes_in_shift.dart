import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_input.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class MinutesInShift extends StatefulWidget {
  const MinutesInShift({
    super.key,
    required this.type,
    this.minutes = 0,
    required this.changeMinutes,
  });

  final EditTimekeeping type;
  final int minutes;
  final ValueChanged<int> changeMinutes;

  @override
  State<MinutesInShift> createState() => _MinutesInShiftState();
}

class _MinutesInShiftState extends State<MinutesInShift> {
  final TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    numberController.text = widget.minutes.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return ContainerBorder(
      borderColors: colors.blue,
      backgroundColors: colors.blue.withOpacity(0.3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.type == EditTimekeeping.late
                  ? appLocalizations.minutesToLate
                  : appLocalizations.minutesToEarly,
              style: TextStyle(
                color: colors.blue,
                fontSize: SpacingUnit.x3_5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: AppInput(
              keyboardType: TextInputType.number,
              placeHolder: "0",
              controller: numberController,
              onChange: (value) => _onChangeMinutes(value),

            ),
          )
        ],
      ),
    );
  }

  _onChangeMinutes(String value) {
    if (value.isNotEmpty) {
      widget.changeMinutes.call(int.parse(value));
    } else {
      widget.changeMinutes.call(0);
    }
  }
}
