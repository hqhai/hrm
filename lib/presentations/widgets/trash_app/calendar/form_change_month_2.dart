import 'dart:ffi';

import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class FormChangeMonth2 extends StatefulWidget {
  final String year;
  final String month;
  final VoidCallback upMonth;
  final VoidCallback downMonth;
  final ValueChanged<bool> onChange;

  const FormChangeMonth2(
      {super.key,
      required this.year,
      required this.month,
      required this.upMonth,
      required this.downMonth,
      required this.onChange});

  @override
  State<FormChangeMonth2> createState() => _FormChangeMonth2State();
}

class _FormChangeMonth2State extends State<FormChangeMonth2> {
  bool checkTypeCalender = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    return Container(
      alignment: Alignment.center,
      height: SpacingUnit.x18,
      padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x3,),
                child: GestureDetector(
                  onTap: () => _setTypeCalender(),
                  child: ContainerBorder(
                    child: Icon(
                      checkTypeCalender ? Icons.horizontal_distribute : Icons.vertical_distribute,
                      size: SpacingUnit.x3,
                      color: colors.text,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "${widget.month} ${widget.year}",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              InkWell(
                onTap: () => widget.upMonth.call(),
                child: Icon(
                  Icons.arrow_drop_up,
                  color: colors.textTertiary,
                  size: SpacingUnit.x12_5,
                ),
              ),
              const SizedBox(
                width: SpacingUnit.x4,
              ),
              InkWell(
                onTap: () => widget.downMonth.call(),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: colors.textTertiary,
                  size: SpacingUnit.x12_5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _setTypeCalender() {
    setState(() {
      checkTypeCalender = !checkTypeCalender;
      widget.onChange.call(checkTypeCalender);
    });
  }
}
