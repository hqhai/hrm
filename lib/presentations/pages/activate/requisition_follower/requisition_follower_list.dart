import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_event.dart';
import 'package:base_app/presentations/pages/activate/requisition_follower/listview_request_follower.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/filter_requisition_approve_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final requisitionFollowerListPageRoute = GoRoute(
    path: Pages.requisitionFollowerListPage,
    name: Pages.requisitionFollowerListPage,
    builder: (context, GoRouterState state) =>
        const RequisitionFollowerListPage());

class RequisitionFollowerListPage extends StatefulWidget {
  const RequisitionFollowerListPage({super.key});

  @override
  State<RequisitionFollowerListPage> createState() =>
      _RequisitionFollowerListPageState();
}

class _RequisitionFollowerListPageState
    extends State<RequisitionFollowerListPage> {
  bool checkOpacity = false, checkLoad = true;
  FilterDialogModel filterData = const FilterDialogModel();
  StatusRequestEnum status = StatusRequestEnum.process;

  @override
  void initState() {
    dI<RequisitionFollowingBloc>()
        .add(const GetRequisitionsFollowingByFilterEvent());
    super.initState();
  }

  setlLstFilter(FilterDialogModel value) async {
    setState(() {
      filterData = value;
      checkLoad = false;
    });
    Completer completer = Completer<bool>();
    dI<RequisitionFollowingBloc>().add(GetRequisitionsFollowingByFilterEvent(
      completer: completer,
      type: value.types,
      status: status,
      userIds: value.user?.code,
      departmentId: value.department?.id,
      startTime: filterData.startTime,
      endTime: filterData.endTime,
      page: 1,
    ));
    final checkCompleter = await completer.future;
    if (checkCompleter) {
      setState(() {
        checkLoad = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: colors.outline.withValues(alpha: 0.3),
            height: SpacingUnit.x0_5,
          ),
        ),
        iconTheme: IconThemeData(color: colors.text),
        title: (Text(
          appLocalizations.singleWordList,
          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
        )),
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
      body: ListviewRequestFollower(
        checkLoad: checkLoad,
        onChangeStatus: (value) => setStatus(value),
        filterData: filterData,
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

  setStatus(StatusRequestEnum value) {
    setState(() {
      status = value;
    });
  }
}
