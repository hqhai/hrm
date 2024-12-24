import 'dart:async';
import 'dart:math';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/listview_request_approve.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/filter_requisition_approve_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final requisitionApproveListPageRoute = GoRoute(
    path: Pages.requisitionApproveListPage,
    builder: (context, GoRouterState state) =>
        const RequisitionApproveListPage());

class RequisitionApproveListPage extends StatefulWidget {
  const RequisitionApproveListPage({super.key});

  @override
  State<RequisitionApproveListPage> createState() =>
      _RequisitionApproveListPageState();
}

class _RequisitionApproveListPageState
    extends State<RequisitionApproveListPage> {
  bool checkOpacity = false;
  bool checkLoad = true;
  var random = Random();

  // String errorDialog = 'that bai';
  FilterDialogModel filterData = const FilterDialogModel();
  EnumStepRequestStatusEnum status = EnumStepRequestStatusEnum.newStatus;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _buttonBack(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: colors.outline.withOpacity(0.3),
            height: SpacingUnit.x0_5,
          ),
        ),
        iconTheme: IconThemeData(color: colors.text),
        title: Text(
          appLocalizations.requisitionYouApproval,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () => _showBottomSheet(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
              child: SvgPicture.asset(
                Assets.images.icon.activateIcon.iconamoonOptionsThin,
                height: SpacingUnit.x6,
                width: SpacingUnit.x6,
                colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
        builder: (context, state) {
          return ListviewRequestApprove(
            checkLoad: checkLoad,
            onChangeStatus: (value) => setStatus(value),
            filterData: filterData,
          );
        },
      ),
      floatingActionButton:
          BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
        builder: (context, state) {
          final isChecked = state.ids.isNotEmpty;
          return isChecked
              ? FloatingActionButton(
                  onPressed: () {
                    _setApproveAll(
                      stepRequestApproverId: state.ids,
                      buildContext: context,
                      filterData: filterData,
                      status: status,
                    );
                  },
                  backgroundColor: Colors.blue,
                  child: Text(
                    appLocalizations.approver,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }

  setlLstFilter(FilterDialogModel value) async {
    setState(() {
      filterData = value;
      checkLoad = false;
    });
    Completer completer = Completer<bool>();
    dI<RequisitionApproveBloc>().add(
      GetRequisitionsApproveByFilterEvent(
        completer: completer,
        page: 1,
        type: value.types,
        status: status,
        departmentId: value.department?.id,
        startTime: value.startTime,
        endTime: value.endTime,
        userIds: value.user?.code,
      ),
    );
    final checkCompleter = await completer.future;
    if (checkCompleter) {
      setState(() {
        checkLoad = true;
      });
    }
  }

  _buttonBack(BuildContext context) {
    dI<AppNavigation>().pop(context);
    dI<RequisitionApproveBloc>().add(const ResetAllIdRequisitionApproveEvent());
  }

  _showBottomSheet() async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    if (!currentContext.mounted) return;
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: false,
      context: currentContext,
      builder: (BuildContext context) {
        return FilterRequisitionApproveDialog(
          filter: filterData,
          sendData: (value) => setlLstFilter(value),
        );
      },
    );
  }

  setStatus(EnumStepRequestStatusEnum value) {
    setState(() {
      status = value;
    });
  }

  _setApproveAll({
    required List<String> stepRequestApproverId,
    required BuildContext buildContext,
    FilterDialogModel? filterData,
    EnumStepRequestStatusEnum? status,
  }) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext);
    final Completer completer = Completer<bool>();

    setCheckLoad();
    dI<RequisitionApproveBloc>().add(AddAllRequisitionEvent(
      stepRequestApproverId: stepRequestApproverId,
      completer: completer,
      userIds: filterData?.user?.id,
      status: status,
      endTime: filterData?.endTime,
      startTime: filterData?.startTime,
      departmentId: filterData?.department?.id,
      type: filterData?.types,
    ));
    final statusCompleter = await completer.future;
    if (currentContext.mounted) {
      if (statusCompleter == true) {
        approverSuccess(title: appLocalizations?.approvedSuccess);
      } else {
        final error = dI<RequisitionApproveBloc>().state.errorCode;
        String errorCodeDialog = error.isNotEmpty
            ? setErrorValue(error, currentContext) ?? error
            : "";
        approverUnsuccessful(errorDialog: errorCodeDialog);
      }
    }
  }
}
