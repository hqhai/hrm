import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/app_input.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themes/themes.dart';

class ItemCreateTotalMinute extends StatefulWidget {
  const ItemCreateTotalMinute(
      {super.key, this.error, this.totalMinuteController, this.onChange, this.title});

  final TextEditingController? totalMinuteController;
  final ValueChanged<String>? onChange;
  final String? title;
  final String? error;

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
        const SizedBox(height: SpacingUnit.x3,),
        TitleRequired(
          title: widget.title ?? "",
          requiredValidate: true,
        ),
        Padding(
          padding: const EdgeInsets.only(top: SpacingUnit.x3),
          child: AppInput(
            placeHolder: widget.title ?? "",
            controller: widget.totalMinuteController,
            onChange: (value) => _onChangeTotalMinute(value),
            inputFormatter: [
              FilteringTextInputFormatter.allow(
                RegExp(numberOfRegexExp),
              ),
            ],
          ),
        ),
        if (widget.error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: SpacingUnit.x3),
            child: Text(
              widget.error ?? "",
              style: TextStyle(
                color: colors.error,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
      ],
    );
  }

  _onChangeTotalMinute(String value) {
    widget.onChange?.call(value);
  }
}
