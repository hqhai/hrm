import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themes/themes.dart';

class ItemCreateTotalMinute extends StatefulWidget {
  const ItemCreateTotalMinute({super.key, this.totalMinuteController, this.onChange, this.title});

  final TextEditingController? totalMinuteController;
  final ValueChanged<String>? onChange;
  final String? title;

  @override
  State<ItemCreateTotalMinute> createState() => _ItemCreateTotalMinuteState();
}

class _ItemCreateTotalMinuteState extends State<ItemCreateTotalMinute> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? "",
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: AppInput(
            placeHolder: widget.title ?? "",
            controller: widget.totalMinuteController,
            onChange: (value) => _onChangeTotalMinute(value),
            inputFormatter: [
              FilteringTextInputFormatter.allow(
                RegExp(numberRegexExp),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _onChangeTotalMinute(String value) {
    widget.onChange?.call(value);
  }
}
