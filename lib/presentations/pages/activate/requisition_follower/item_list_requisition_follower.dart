import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_follower/content_item_follwer_requisition_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
  bool checkOpacity = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionFollowingBloc, RequisitionFollowingState>(
      builder: (context, state) =>
          BlocBuilder<LanguageCubit, LanguageState>(builder: (context, stateLanguage) {
        final request = state.requisitions[widget.id];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SpacingUnit.x1),
            color: colors.background,
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
                        alignment: Alignment.topRight,
                        child: Container(
                          color: colors.neutralVariant40,
                          padding: const EdgeInsets.all(SpacingUnit.x2),
                          child: Text(
                            StatusRequestEnum.values
                                .firstWhere((e) => e == request?.status)
                                .configRequestStatusName,
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: SpacingUnit.x2),
                        child: ContentItemFollowingRequisitionList(id: widget.id),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  _nextRequisitionInformationScreen(BuildContext context) async {
    if (!checkOpacity) {
      setState(() {
        checkOpacity = true;
      });
      final Completer completer = Completer<bool>();
      final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      dI<RequisitionBloc>().add(
        GetRequisitionByIdEvent(id: widget.id, completer: completer),
      );
      final statusCompleter = await completer.future;
      if (statusCompleter == true) {
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
