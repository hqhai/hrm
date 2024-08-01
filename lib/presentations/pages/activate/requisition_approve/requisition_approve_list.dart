import 'dart:math';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/pages/activate/requisition_approve/listview_request_approve.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/filter_requisition_approve_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final requisitionApproveListPageRoute = GoRoute(
    path: Pages.requisitionApproveListPage,
    name: Pages.requisitionApproveListPage,
    builder: (context, GoRouterState state) => const RequisitionApproveListPage());

class RequisitionApproveListPage extends StatefulWidget {
  const RequisitionApproveListPage({super.key});

  @override
  State<RequisitionApproveListPage> createState() => _RequisitionApproveListPageState();
}

class _RequisitionApproveListPageState extends State<RequisitionApproveListPage> {
  bool checkOpacity = false;
  var random = Random();
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
        iconTheme: IconThemeData(color: colors.text),
        title: (Text(
          appLocalizations.singleWordList,
          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
        )),
        actions: [
          GestureDetector(
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
      body: ListviewRequestApprove(
        onChangeStatus: (value) => setStatus(value),
        filterData: filterData,
      ),
    );
  }

  setlLstFilter(FilterDialogModel value) {
    setState(() {
      filterData = value;
    });
    dI<RequisitionApproveBloc>().add(
      GetRequisitionsApproveByFilterEvent(
        page: 1,
        type: value.types,
        status: status,
        departmentId: value.department?.code,
        startTime: value.startTime,
        endTime: value.endTime,
        userIds: value.user?.code,
      ),
    );
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
}
