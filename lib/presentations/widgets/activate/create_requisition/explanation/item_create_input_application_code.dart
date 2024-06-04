import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class ItemCreateInputApplicationCode extends StatefulWidget {
  const ItemCreateInputApplicationCode({super.key, this.textController, this.onChange});

  final TextEditingController? textController;
  final ValueChanged<String>? onChange;

  @override
  State<ItemCreateInputApplicationCode> createState() => _ItemCreateInputApplicationCodeState();
}

class _ItemCreateInputApplicationCodeState extends State<ItemCreateInputApplicationCode> {
  String time = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
  bool check = false;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.applicationCode,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: AppInput(
            placeHolder: appLocalizations.applicationCode,
            controller: widget.textController,
            onChange: (value) => _onChangeTotalMinute(value),
          ),
        ),
        ElevatedButton(
          onPressed: () => _onClick(),
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.blue,
          ),
          child: Text(
            appLocalizations.check,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x3,
            ),
          ),
        ),
        if(check)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
                child: Text(
                  appLocalizations.timeHasBeenRequestedInAdvance,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                appLocalizations.startTime,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x3,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(SpacingUnit.x1),
                margin: const EdgeInsets.all(SpacingUnit.x3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SpacingUnit.x1),
                  color: colors.surface,
                  border: Border.all(
                    color: colors.text,
                    width: 1,
                  ),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ),
              Text(
                appLocalizations.endTime,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x3,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(SpacingUnit.x1),
                margin: const EdgeInsets.all(SpacingUnit.x3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SpacingUnit.x1),
                  color: colors.surface,
                  border: Border.all(
                    color: colors.text,
                    width: 1,
                  ),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }

  _onChangeTotalMinute(String value) {
    widget.onChange?.call(value);
  }

  _onClick() {
    setState(() {
      check = true;
    });
  }
}
