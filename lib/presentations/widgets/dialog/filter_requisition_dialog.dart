import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class FilterRequisitionDialog extends StatefulWidget {
  const FilterRequisitionDialog({super.key, required this.sendData});

  final ValueChanged<FilterDialogModel> sendData;

  @override
  State<FilterRequisitionDialog> createState() => _FilterRequisitionDialogState();
}

class _FilterRequisitionDialogState extends State<FilterRequisitionDialog> {
  String type = '', startTime = '', endTime = '';
  List<String> statuses = [];

  void setType({RequisitionTypeEnum? value}) {
    type = _setNameType(value);
  }

  void saveDrag({required String a}) {
    if (!statuses.contains(a)) {
      setState(() {
        statuses.add(a);
      });
    } else {
      setState(() {
        statuses.remove(a);
      });
    }
  }

  void setStartTime({required String value}) {
    startTime = value;
  }

  void setEndTime({required String value}) {
    endTime = value;
  }

  String _setNameStatus(StatusRequisitionEnum e) {
    LanguageEnum languageEnum = dI<LanguageCubit>().state.languageCode;
    if (languageEnum == LanguageEnum.vi) {
      return e.nameVi;
    } else {
      return e.nameEn;
    }
  }

  String _setNameType(RequisitionTypeEnum? e) {
    LanguageEnum languageEnum = dI<LanguageCubit>().state.languageCode;
    if (e == null) {
      return '';
    } else {
      if (languageEnum == LanguageEnum.vi) {
        return e.nameVi;
      } else {
        return e.nameEn;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      width: width,
      height: height * 0.6,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(appLocalizations.filter,
                  textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x4)),
            ),
            Divider(
              color: colors.text,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(SpacingUnit.x2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.type,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: SpacingUnit.x3,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  Center(
                    child: DropdownMenu<RequisitionTypeEnum>(
                      textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                      initialSelection: RequisitionTypeEnum.explanation,
                      onSelected: (RequisitionTypeEnum? value) => setType(value: value),
                      dropdownMenuEntries: RequisitionTypeEnum.values
                          .map((e) => e)
                          .map<DropdownMenuEntry<RequisitionTypeEnum>>((RequisitionTypeEnum value) {
                        return DropdownMenuEntry<RequisitionTypeEnum>(
                            value: value,
                            label: dI<LanguageCubit>().state.languageCode == LanguageEnum.en
                                ? value.nameEn
                                : value.nameVi);
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  Text(
                    appLocalizations.startTime,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  DatePicker(
                    onChange: (value) => setStartTime(value: value),
                    check: true,
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  Text(
                    appLocalizations.endTime,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  DatePicker(
                    onChange: (value) => setEndTime(value: value),
                    check: true,
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  Text(
                    appLocalizations.status,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  Wrap(
                    spacing: SpacingUnit.x4,
                    runSpacing: SpacingUnit.x3,
                    children: StatusRequisitionEnum.values
                        .map((e) => _setNameStatus(e))
                        .map(
                          (eName) => GestureDetector(
                            onTap: () => saveDrag(a: eName),
                            child: Container(
                              padding: const EdgeInsets.all(SpacingUnit.x1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(SpacingUnit.x1),
                                color: statuses.contains(eName)
                                    ? colors.error
                                    : CustomsColor.colorBackground,
                                border: Border.all(color: colors.text, width: SpacingUnit.x0_25),
                              ),
                              child: Text(eName),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.sendData.call(FilterDialogModel(
                        type: type, endTime: endTime, startTime: startTime, statuses: statuses));
                    popDialog(context);
                  },
                  child: Text(appLocalizations.apply),
                ),
                ElevatedButton(
                  onPressed: () => popDialog(context),
                  child: Text(appLocalizations.cancel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
