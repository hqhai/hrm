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

filterRequisitionDialog(BuildContext context, ValueChanged<FilterDialogModel> sendData) async {
  final appLocalizations = AppLocalizations.of(context)!;
  final colors = AppTheme.getColors(context);
  final width = MediaQuery.sizeOf(context).width;
  final height = MediaQuery.sizeOf(context).height;
  String type = '', startTime = '', endTime = '';
  List<String> statuses = [];
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(appLocalizations.filter,
            textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x4)),
        contentPadding: const EdgeInsets.all(0),
        content: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: colors.text,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appLocalizations.type,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800)),
                      const SizedBox(height: SpacingUnit.x3),
                      Center(
                        child: DropdownMenu<RequisitionTypeEnum>(
                          textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                          initialSelection: RequisitionTypeEnum.explanation,
                          onSelected: (RequisitionTypeEnum? value) => type = value?.nameVi ?? '',
                          dropdownMenuEntries: RequisitionTypeEnum.values
                              .map((e) => e)
                              .map<DropdownMenuEntry<RequisitionTypeEnum>>(
                                  (RequisitionTypeEnum value) {
                            return DropdownMenuEntry<RequisitionTypeEnum>(
                                value: value,
                                label: dI<LanguageCubit>().state.languageCode == LanguageEnum.en
                                    ? value.nameEn
                                    : value.nameVi);
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: SpacingUnit.x3),
                      Text(appLocalizations.startTime,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800)),
                      const SizedBox(height: SpacingUnit.x3),
                      DatePicker(
                        onChange: (value) {
                          startTime = value;
                        },
                        check: true,
                      ),
                      const SizedBox(height: SpacingUnit.x3),
                      Text(appLocalizations.endTime,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800)),
                      const SizedBox(height: SpacingUnit.x3),
                      DatePicker(
                        onChange: (value) {
                          endTime = value;
                        },
                        check: true,
                      ),
                      const SizedBox(height: SpacingUnit.x3),
                      Text(appLocalizations.status,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800)),
                      const SizedBox(height: SpacingUnit.x3),
                      Wrap(
                        spacing: SpacingUnit.x4,
                        runSpacing: SpacingUnit.x3,
                        children: StatusRequisitionEnum.values
                            .map((e) => setNameStatus(e))
                            .map((a) => GestureDetector(
                                  onTap: () {
                                    _saveDrag(a: a, status: statuses);
                                    /*if (!statuses.contains(a)) {
                                      statuses.add(a);
                                    } else {
                                      statuses.remove(a);
                                    }*/
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(SpacingUnit.x1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(SpacingUnit.x1),
                                        color: CustomsColor.colorBackground,
                                        border: Border.all(
                                            color: colors.text, width: SpacingUnit.x0_25)),
                                    child: Text(a),
                                  ),
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  sendData.call(FilterDialogModel(
                      type: type, endTime: endTime, startTime: startTime, statuses: statuses));
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
      );
    },
  );
}

String setNameStatus(StatusRequisitionEnum e) {
  LanguageEnum languageEnum = dI<LanguageCubit>().state.languageCode;
  if (languageEnum == LanguageEnum.vi) {
    return e.nameVi;
  } else {
    return e.nameEn;
  }
}

String setNameType(RequisitionTypeEnum? e) {
  LanguageEnum languageEnum = dI<LanguageCubit>().state.languageCode;
  if (e != null) {
    return '';
  } else {
    if (languageEnum == LanguageEnum.vi) {
      return e!.nameVi;
    } else {
      return e!.nameEn;
    }
  }
}

void _saveDrag({required String a, required List<String> status}) {
  if (!status.contains(a)) {
    status.add(a);
  } else {
    status.remove(a);
  }
}
