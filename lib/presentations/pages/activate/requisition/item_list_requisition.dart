import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemRequisitionList extends StatefulWidget {
  const ItemRequisitionList({super.key, this.indexType = 0, this.indexStatus = 0});

  final int indexType;
  final int indexStatus;

  @override
  State<ItemRequisitionList> createState() => _ItemRequisitionListState();
}

class _ItemRequisitionListState extends State<ItemRequisitionList> {
  List<String> nameType = [];
  List<String> nameStatus = [];
  final String creator = 'Nguyen Van A, Nguyen Van A, Nguyen Van A, Nguyen Van A';
  final String time = formatYMDHMS(DateTime.now().toString());

  @override
  void initState() {
    super.initState();
    LanguageEnum languageEnum = dI<LanguageCubit>().state.languageCode;
    nameType = RequisitionTypeEnum.values.map((e) => setNameType(e, languageEnum)).toList();
    nameStatus = StatusRequisitionEnum.values.map((e) => setNameStatus(e, languageEnum)).toList();
  }

  String setNameType(RequisitionTypeEnum e, LanguageEnum language) {
    if (language == LanguageEnum.vi) {
      return e.nameVi;
    } else {
      return e.nameEn;
    }
  }

  String setNameStatus(StatusRequisitionEnum e, LanguageEnum language) {
    if (language == LanguageEnum.vi) {
      return e.nameVi;
    } else {
      return e.nameEn;
    }
  }

  _listener(BuildContext context, LanguageState state) {
    nameType = RequisitionTypeEnum.values.map((e) => setNameType(e, state.languageCode)).toList();
    nameStatus =
        StatusRequisitionEnum.values.map((e) => setNameStatus(e, state.languageCode)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BlocListener<LanguageCubit, LanguageState>(
      listener: (context, state) => _listener(context, state),
      child: Container(
        height: height * 0.15,
        margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SpacingUnit.x1),
            color: CustomsColor.colorBackground,
            border: Border.all(color: colors.text, width: 1)),
        child: Stack(children: [
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  color: colors.neutralVariant40,
                  padding: const EdgeInsets.all(SpacingUnit.x2),
                  child: Text(nameStatus[widget.indexStatus],
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)))),
          if (widget.indexStatus == 2)
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  margin: const EdgeInsets.all(SpacingUnit.x2),
                  padding: const EdgeInsets.all(SpacingUnit.x2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SpacingUnit.x1),
                      color: CustomsColor.colorBackground,
                      border: Border.all(color: colors.text, width: 1)),
                  child: Text(
                    appLocalizations.update,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                  )),
            ),
          Padding(
              padding: const EdgeInsets.all(SpacingUnit.x2),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                    width: width * 0.7,
                    child: Text(nameType[widget.indexType],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3_5,
                            fontWeight: FontWeight.w700))),
                const SizedBox(height: SpacingUnit.x3_5),
                Row(children: [
                  Text('${appLocalizations.creator} : ',
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)),
                  SizedBox(
                      width: width * 0.6,
                      child: Text(creator,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)))
                ]),
                Row(children: [
                  Text('${appLocalizations.createTime} : ',
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)),
                  SizedBox(
                      width: width * 0.6,
                      child: Text(time,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)))
                ]),
                Row(children: [
                  Text('${appLocalizations.deadline} : ',
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)),
                  SizedBox(
                      width: width * 0.6,
                      child: Text(time,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)))
                ]),
              ]))
        ]),
      ),
    );
  }
}
