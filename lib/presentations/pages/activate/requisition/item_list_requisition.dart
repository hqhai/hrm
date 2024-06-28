import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:themes/themes.dart';

class ItemRequisitionList extends StatefulWidget {
  const ItemRequisitionList({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ItemRequisitionList> createState() => _ItemRequisitionListState();
}

class _ItemRequisitionListState extends State<ItemRequisitionList> {
  bool checkOpacity = false;

  @override
  void initState() {
    super.initState();
  }

  Request _getRequestInId(RequisitionState state) {
    Request request = state.requisitions.firstWhere((element) => element.id == widget.id);
    return request;
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
          child: GestureDetector(
            onTap: () => _nextRequisitionInformationScreen(context, state),
            child: Stack(
              children: [
                Opacity(
                  opacity: checkOpacity ? 0.5 : 1,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          color: colors.neutralVariant40,
                          padding: const EdgeInsets.all(SpacingUnit.x2),
                          child: Text(
                              StatusRequestEnum.values
                                  .firstWhere((e) => e == _getRequestInId(state).status)
                                  .configRequestStatusName,
                              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)))),
                ),
                if (_getRequestInId(state).status == StatusRequestEnum.edit)
                  Opacity(
                    opacity: checkOpacity ? 0.5 : 1,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          margin: const EdgeInsets.all(SpacingUnit.x2),
                          padding: const EdgeInsets.all(SpacingUnit.x2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(SpacingUnit.x1),
                            color: CustomsColor.colorBackground,
                            border: Border.all(color: colors.text, width: 1),
                          ),
                          child: Text(
                            appLocalizations.update,
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                          )),
                    ),
                  ),
                if (_getRequestInId(state).status == StatusRequestEnum.process)
                  Opacity(
                    opacity: checkOpacity ? 0.5 : 1,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          margin: const EdgeInsets.all(SpacingUnit.x2),
                          padding: const EdgeInsets.all(SpacingUnit.x2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(SpacingUnit.x1),
                            color: CustomsColor.colorBackground,
                            border: Border.all(color: colors.text, width: 1),
                          ),
                          child: Text(
                            appLocalizations.revoke,
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                          )),
                    ),
                  ),
                Opacity(
                  opacity: checkOpacity ? 0.5 : 1,
                  child: Padding(
                    padding: const EdgeInsets.all(SpacingUnit.x2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: width * 0.7,
                            child: Text(_getRequestInId(state).config.description ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: colors.text,
                                    fontSize: SpacingUnit.x3_5,
                                    fontWeight: FontWeight.w700))),
                        const SizedBox(height: SpacingUnit.x3_5),
                        Row(children: [
                          Text(
                            '${appLocalizations.creator} : ',
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                          ),
                          SizedBox(
                              width: width * 0.6,
                              child: Text(_getRequestInId(state).createdFullName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)))
                        ]),
                        Row(children: [
                          Text('${appLocalizations.createTime} : ',
                              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)),
                          SizedBox(
                              width: width * 0.6,
                              child: Text(formatYMDHMS(_getRequestInId(state).createdDate),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)))
                        ]),
                        Row(
                          children: [
                            Text('${appLocalizations.code} : ',
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)),
                            SizedBox(
                                width: width * 0.6,
                                child: Text(_getRequestInId(state).code,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: colors.successVariant, fontSize: SpacingUnit.x3_5)))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Opacity(
                  opacity: checkOpacity ? 1 : 0,
                  child: Center(
                    child: Lottie.asset(Assets.images.icon.loading,
                        width: SpacingUnit.x40, height: SpacingUnit.x40, fit: BoxFit.fill),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _nextRequisitionInformationScreen(BuildContext context, RequisitionState state) async {
    Request request = _getRequestInId(state);
    if (!checkOpacity) {
      setState(() {
        checkOpacity = true;
      });
      final Completer completer = Completer<RequisitionEnum>();
      final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      dI<RequisitionBloc>().add(
        GetRequisitionByIdEvent(id: widget.id, completer: completer),
      );
      final statusCompleter = await completer.future;
      if (statusCompleter == RequisitionEnum.success) {
        setState(() {
          checkOpacity = false;
        });
        if (!currentContext.mounted) return;
        dI<AppNavigation>().pushName(
          currentContext,
          page: Pages.requisitionInformationPage,
          extra: {
            'id': request.id,
            'checkUser': false,
          },
        );
      }
    }
  }
}
