import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/custom/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';

class ItemCreateOTOrOL extends StatefulWidget {
  const ItemCreateOTOrOL(
      {super.key,
      required this.onChangeStartTime,
      required this.onChangeEndTime,
      required this.onChangeContent,
      required this.onChangeTitle,
      this.title = '',
      this.content = '',
      this.type = ''});

  final ValueChanged<String> onChangeStartTime;
  final ValueChanged<String> onChangeEndTime;
  final ValueChanged<String> onChangeTitle;
  final ValueChanged<String> onChangeContent;
  final String title, content, type;

  @override
  State<ItemCreateOTOrOL> createState() => _ItemCreateOTOrOLState();
}

class _ItemCreateOTOrOLState extends State<ItemCreateOTOrOL> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = '';
    commentsController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    commentsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    appLocalizations.startTime,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    appLocalizations.endTime,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: TimePicker(
                    onChange: (value) => {widget.onChangeStartTime.call(value)},
                    timeSlot: widget.type == '' ? 'S' : 'V',
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 2,
                  child: TimePicker(
                      onChange: (value) => {widget.onChangeEndTime.call(value)},
                      timeSlot: widget.type == '' ? 'E' : 'V'),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: SpacingUnit.x6_5,
        ),
        Text(
          widget.title,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4_5,
          ),
        ),
        const SizedBox(
          height: SpacingUnit.x4_5,
        ),
        AppInput(
          placeHolder: widget.title,
          controller: titleController,
          onChange: (value) {
            widget.onChangeTitle.call(value);
          },
        ),
        const SizedBox(
          height: SpacingUnit.x6_5,
        ),
        Text(
          widget.content,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4_5,
          ),
        ),
        const SizedBox(
          height: SpacingUnit.x4_5,
        ),
        AppInputArea(
          placeHolder: widget.content,
          controller: commentsController,
          onChange: (value) {
            widget.onChangeContent.call(value);
          },
        ),
      ],
    );
  }
}
