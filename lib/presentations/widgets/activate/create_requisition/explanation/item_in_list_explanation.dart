import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/explanation.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/app_start_end_time.dart';
import 'package:base_app/presentations/widgets/custom/date_picker_cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemInListExplanation extends StatefulWidget {
  const ItemInListExplanation({
    super.key,
    this.explanation = const Explanation(),
    required this.changeExplanation,
    required this.callBackDelete,
  });

  final Explanation explanation;
  final VoidCallback callBackDelete;
  final ValueChanged<Explanation> changeExplanation;

  @override
  State<ItemInListExplanation> createState() => _ItemInListExplanationState();
}

class _ItemInListExplanationState extends State<ItemInListExplanation> {
  final TextEditingController noteController = TextEditingController();
  String note = '', errorTime = '';
  bool checkTypeContainer = true;

  @override
  void initState() {
    noteController.text = widget.explanation.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DatePickerLoop(
          callBack: () => _setContainer(),
          changeType: true,
          checkError: true,
          maxDate: DateTime.now(),
          typeContainer: checkTypeContainer,
          oldDate: widget.explanation.workDate,
          onChange: (value) => setDate(value),
        ),
        if (checkTypeContainer) ...[
          AppStartEndTime(
            checkNumberValue: false,
            endTime: widget.explanation.checkOut,
            startTime: widget.explanation.checkIn,
            numberValue: 0,
            title1: appLocalizations.realCheckIn,
            title2: appLocalizations.realCheckOut,
            title3: appLocalizations.totalMakeUpWorkTime,
            setEndTime: (value) => _setEndTime(
              value: value,
              title: appLocalizations.endTimeMustBeAfterStartTime,
            ),
            setStartTime: (value) => _setStartTime(
              value: value,
              title: appLocalizations.endTimeMustBeAfterStartTime,
            ),
            errorTime: errorTime,
          ),
          const SizedBox(height: SpacingUnit.x4),
          ItemCreateInputArea(
            error: note.isNotEmpty ? "" : appLocalizations.cannotBeLeftBlank,
            requiredValidate: true,
            textController: noteController,
            title: appLocalizations.note,
            onChange: (value) => _setNote(value),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: SpacingUnit.x4, horizontal: SpacingUnit.x1),
            child: AppButton(
              colorText: colors.background,
              title: appLocalizations.cancel,
              onSubmit: () => widget.callBackDelete.call(),
              color: colors.error.withOpacity(0.7),
            ),
          ),
        ],
      ],
    );
  }

  _setNote(String value) {
    setState(() {
      final explanation = widget.explanation.copyWith(note: value);
      note = value;
      widget.changeExplanation(explanation);
    });
  }

  _setContainer() {
    setState(() {
      checkTypeContainer = !checkTypeContainer;
    });
  }

  _setEndTime({required int value, required String title}) {
    setState(() {
      final explanation = widget.explanation.copyWith(checkOut: value);
      widget.changeExplanation.call(explanation);
      final total =
          double.parse((value - widget.explanation.checkIn).toString());
      errorTime = total > 0 ? "" : title;
    });
  }

  _setStartTime({required int value, required String title}) {
    setState(() {
      final explanation = widget.explanation.copyWith(checkIn: value);
      widget.changeExplanation.call(explanation);
      final total =
          double.parse((widget.explanation.checkOut - value).toString());
      errorTime = total > 0 ? "" : title;
    });
  }

  setDate(DateTime value) {
    final explanation = widget.explanation.copyWith(workDate: value);
    widget.changeExplanation.call(explanation);
  }
}
