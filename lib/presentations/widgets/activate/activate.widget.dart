import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/item_data.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_event.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
import 'package:base_app/presentations/widgets/dialog/no_connection/no_connection_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ActivateWidget extends StatefulWidget {
  const ActivateWidget({super.key});

  @override
  State<ActivateWidget> createState() => _ActivateWidgetState();
}

class _ActivateWidgetState extends State<ActivateWidget> {
  late String _errorName = '';

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      color: colors.secondaryContainer.withOpacity(0.1),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(SpacingUnit.x4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: ItemUtils.listActivate
                  .mapIndexed(
                    (index, element) => ItemActivateWidget(
                      title: ItemUtils.titlesActivate(index, context),
                      callback: () => _nextScreen(context, index),
                    ),
                  )
                  .toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: BlocListener<FlowBloc, FlowState>(
              listener: (context, state) {
                if (state.errorCode != null) {
                  _setErrorCode(errorCode: state.errorCode ?? '');
                }
              },
              child: IconButton(
                onPressed: () => _nextCreateScreen(context),
                icon: Icon(
                  Icons.add_circle_rounded,
                  color: colors.primary,
                  size: SpacingUnit.x12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _nextScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        _nextLeaveScreen(context);
      case 1:
        _nextMyRequestScreen(context);
      case 2:
        _nextApproveRequestScreen(context);
      case 3:
        _nextFollowerRequestScreen(context);
    }
  }

  startTime(DateTime value) {}

  endTime(DateTime value) {}

  _nextLeaveScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.leavePage);
  }

  _nextMyRequestScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    final Completer completerRequest = Completer<bool>();
    dialogIndicator(
      context: context,
    );
    dI<RequisitionBloc>().add(
      GetRequisitionsByFilterEvent(
        completer: completerRequest,
        page: 1,
        status: StatusRequestEnum.process,
      ),
    );
    dI<FlowBloc>().add(GetFlowsEvent(completer: completer));
    final checkRequest = await completerRequest.future;
    final check = await completer.future;
    if (check && checkRequest) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>()
          .pushName(currentContext, page: Pages.requisitionListPage);
    } else {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dialogNoConnection(context: currentContext);
    }
  }

  _nextApproveRequestScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    dialogIndicator(
      context: context,
    );
    final Completer completerDepartment = Completer<bool>();
    dI<DepartmentBloc>().add(
      GetListDepartmentEvent(completer: completerDepartment),
    );
    dI<RequisitionApproveBloc>().add(
      GetRequisitionsApproveByFilterEvent(
        completer: completer,
        page: 1,
        status: EnumStepRequestStatusEnum.newStatus,
      ),
    );
    final check = await completer.future;
    final checkDepartment = await completer.future;
    if (check && checkDepartment) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(currentContext);
      dI<AppNavigation>()
          .push(currentContext, page: Pages.requisitionApproveListPage);
    } else {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(currentContext);
      dialogNoConnection(context: currentContext);
    }
  }

  _nextFollowerRequestScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    dialogIndicator(
      context: context,
    );
    dI<RequisitionFollowingBloc>().add(
      GetRequisitionsFollowingByFilterEvent(
        completer: completer,
        page: 1,
        status: StatusRequestEnum.process,
      ),
    );
    final check = await completer.future;
    if (check) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>()
          .pushName(currentContext, page: Pages.requisitionFollowerListPage);
    } else {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dialogNoConnection(context: currentContext);
    }
  }

  _nextCreateScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    dialogIndicator(
      context: context,
    );
    dI<FlowBloc>().add(
      GetFlowsEvent(
        completer: completer,
        page: 1,
      ),
    );
    final check = await completer.future;
    if (check) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>()
          .pushName(currentContext, page: Pages.createRequestPage);
    } else {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dialogNoConnection(
        context: currentContext,
        error: _errorName,
      );
    }
  }

  void _setErrorCode({
    required String errorCode,
  }) {
    final appLocalizations = AppLocalizations.of(context)!;
    final Map<String, String> errorCodes = {
      'EmployeeNotFullTimeOrPartTime':
          appLocalizations.i18nNotFullTimeOrPartTime,
    };
    setState(() {
      _errorName = errorCodes[errorCode] ?? '';
    });
  }
}
