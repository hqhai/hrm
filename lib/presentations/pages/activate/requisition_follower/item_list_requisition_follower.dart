import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemRequisitionFollowerList extends StatefulWidget {
  const ItemRequisitionFollowerList({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ItemRequisitionFollowerList> createState() => _ItemRequisitionFollowerListState();
}

class _ItemRequisitionFollowerListState extends State<ItemRequisitionFollowerList> {
  @override
  void initState() {
    super.initState();
  }

  Request _getRequestInId(RequisitionFollowingState state) {
    Request request = state.requisitions.firstWhere((element) => element.id == widget.id);
    return request;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<RequisitionFollowingBloc, RequisitionFollowingState>(
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
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    color: colors.neutralVariant40,
                    padding: const EdgeInsets.all(SpacingUnit.x2),
                    child: Text(
                      StatusRequestEnum.values
                          .firstWhere((e) => e == _getRequestInId(state).status)
                          .configRequestStatusName,
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: width * 0.7,
                          child: Text(_getRequestInId(state).description ?? "",
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
                            child: Text(_getRequestInId(state).createdFullName ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)))
                      ]),
                      Row(children: [
                        Text('${appLocalizations.createTime} : ',
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)),
                        SizedBox(
                            width: width * 0.6,
                            child: Text(formatYMDHMS(_getRequestInId(state).createdDate ?? ""),
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
                              child: Text(_getRequestInId(state).code ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: colors.successVariant, fontSize: SpacingUnit.x3_5)))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _nextRequisitionInformationScreen(BuildContext context, RequisitionFollowingState state) {
    Request request = _getRequestInId(state);
    dI<AppNavigation>().pushName(context, page: Pages.requisitionInformationPage, extra: {
      'id': request.id,
      'checkUser': false,
    });
  }
}
