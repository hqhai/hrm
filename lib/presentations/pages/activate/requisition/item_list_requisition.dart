import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemRequisitionList extends StatefulWidget {
  const ItemRequisitionList({
    super.key,
    this.index = 0,
  });

  final int index;

  @override
  State<ItemRequisitionList> createState() => _ItemRequisitionListState();
}

class _ItemRequisitionListState extends State<ItemRequisitionList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) => BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, stateLanguage) => Container(
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
                    child: Text(setNameStatus(getStatus(state), stateLanguage.languageCode),
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)))),
            if (state.requisitions[widget.index].status ==
                StatusRequisitionEnum.modification.nameEn)
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
                      child: Text(
                          state.requisitions[widget.index].type.configTypeName,
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
                        child: Text(state.requisitions[widget.index].creator ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)))
                  ]),
                  Row(children: [
                    Text('${appLocalizations.createTime} : ',
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)),
                    SizedBox(
                        width: width * 0.6,
                        child: Text(state.requisitions[widget.index].createTime ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)))
                  ]),
                  Row(children: [
                    Text('${appLocalizations.deadline} : ',
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)),
                    SizedBox(
                        width: width * 0.6,
                        child: Text(state.requisitions[widget.index].deadLine ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)))
                  ]),
                ]))
          ]),
        ),
      ),
    );
  }

  RequisitionTypeEnum getType(RequisitionState state) {
    return RequisitionTypeEnum.values
        .where((e) => e.nameEn == state.requisitions[widget.index].type.nameEn)
        .first;
  }

  StatusRequisitionEnum getStatus(RequisitionState state) {
    return StatusRequisitionEnum.values
        .where((e) => e.nameEn == state.requisitions[widget.index].status)
        .first;
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
}
