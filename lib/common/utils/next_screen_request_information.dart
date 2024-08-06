import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/cupertino.dart';

nextScreenRequest({
  required VoidCallback setState,
  required String id,
  required bool checkOpacity,
  required RequestSeeByWho checkUser,
  required BuildContext context,
}) async {
  if (!checkOpacity) {
    setState.call();
    final Completer completer = Completer<bool>();
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dialogIndicator(context: currentContext);
    dI<RequisitionBloc>().add(
      GetRequisitionByIdEvent(id: id, completer: completer),
    );
    final statusCompleter = await completer.future;
    if (statusCompleter == true) {
      setState.call();
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(currentContext);
      dI<AppNavigation>().pushName(
        currentContext,
        page: Pages.requisitionInformationPage,
        extra: {
          'id': id,
          'checkUser': checkUser,
        },
      );
    }
  }
}

String intervalOnLeave(DateTime? startDate, DateTime? endDate) {
  String start = (startDate ?? '').toString();
  String end = (endDate ?? '').toString();
  return '${formatYMD(start)} - ${formatYMD(end)}';
}
