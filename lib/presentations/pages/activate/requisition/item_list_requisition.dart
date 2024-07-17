import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/pages/activate/requisition/content_item_my_requisition_list.dart';
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

  Request _getRequestInId(List<Request> requisitions) {
    Request request = requisitions.firstWhere((element) => element.id == widget.id);
    return request;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) => BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, stateLanguage) => Container(
          margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SpacingUnit.x1),
            color: CustomsColor.colorBackground,
            border: Border.all(color: colors.text, width: 1),
          ),
          child: GestureDetector(
            onTap: () => _nextRequisitionInformationScreen(context),
            child: Stack(
              children: [
                Opacity(
                  opacity: checkOpacity ? 1 : 0,
                  child: Center(
                    child: Lottie.asset(Assets.images.icon.loading,
                        width: SpacingUnit.x40, height: SpacingUnit.x40, fit: BoxFit.fill),
                  ),
                ),
                Opacity(
                  opacity: checkOpacity ? 0.5 : 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          color: colors.neutralVariant40,
                          padding: const EdgeInsets.all(SpacingUnit.x2),
                          child: Text(
                            StatusRequestEnum.values
                                .firstWhere((e) => e == _getRequestInId(state.requisitions).status)
                                .configRequestStatusName,
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: SpacingUnit.x2),
                        child: ContentItemMyRequisitionList(id: widget.id),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _nextRequisitionInformationScreen(BuildContext context) async {
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
            'id': widget.id,
            'checkUser': false,
          },
        );
      }
    }
  }
}
