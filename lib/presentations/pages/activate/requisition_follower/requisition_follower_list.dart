import 'dart:math';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/popup_menu_requisition_list.dart';
import 'package:base_app/presentations/pages/activate/requisition_follower/item_list_requisition_follower.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/filter_requisition_approve_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final requisitionFollowerListPageRoute = GoRoute(
    path: Pages.requisitionFollowerListPage,
    name: Pages.requisitionFollowerListPage,
    builder: (context, GoRouterState state) => const RequisitionFollowerListPage());

class RequisitionFollowerListPage extends StatefulWidget {
  const RequisitionFollowerListPage({super.key});

  @override
  State<RequisitionFollowerListPage> createState() => _RequisitionFollowerListPageState();
}

class _RequisitionFollowerListPageState extends State<RequisitionFollowerListPage> {
  bool checkOpacity = false;
  var random = Random();
  int pageIndex = 1, totalItems = 0, lengthList = 0;
  late ScrollController controller;
  FilterDialogModel filterData = const FilterDialogModel();
  List<StatusRequestEnum> listStatusFilter = [];

  @override
  void initState() {
    dI<RequisitionFollowingBloc>().add(const GetRequisitionsFollowingByFilterEvent());
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (lengthList < totalItems &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<RequisitionFollowingBloc>().add(
        GetRequisitionsFollowingByFilterEvent(
          type: filterData.types,
          status: filterData.status,
          departmentId: filterData.department?.id,
          userIds: filterData.user?.id,
          startTime: filterData.startTime,
          endTime: filterData.endTime,
          page: pageIndex,
        ),
      );
    }
  }

  setlLstFilter(FilterDialogModel value) {
    setState(() {
      filterData = value;
    });
    dI<RequisitionFollowingBloc>().add(GetRequisitionsFollowingByFilterEvent(
      startTime: filterData.startTime,
      endTime: filterData.endTime,
      page: 1,
    ));
  }

  _listener(BuildContext context, RequisitionFollowingState state) {
    setState(() {
      totalItems = state.countItem;
      lengthList = state.requisitions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: (Text(
          appLocalizations.singleWordList,
          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
        )),
        actions: [PopupMenuRequisitionList(onChangeCheckOpacity: (value) => _opacity(value))],
      ),
      body: Opacity(
        opacity: checkOpacity ? 0.5 : 1,
        child: BlocConsumer<RequisitionFollowingBloc, RequisitionFollowingState>(
          listener: (context, state) => _listener(context, state),
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  height: height * 0.04,
                  margin: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => dialog(context),
                      child: Container(
                        color: colors.background,
                        height: height * 0.04,
                        child: SvgPicture.asset(
                          Assets.images.icon.activateIcon.iconamoonOptionsThin,
                          colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                  margin: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                  height: height * 0.78,
                  decoration: BoxDecoration(
                    color: colors.background,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(SpacingUnit.x1),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: height * 0.75,
                      child: Stack(
                        children: [
                          ListView.builder(
                            controller: controller,
                            itemCount: state.requisitions.length,
                            itemBuilder: (context, index) =>
                                ItemRequisitionFollowerList(id: state.requisitionIds[index]),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(SpacingUnit.x20),
                                  color: colors.background,
                                  border: Border.all(color: colors.polarGreen, width: 1)),
                              child: Icon(Icons.add, color: colors.polarGreen, size: width * 0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _opacity(bool check) {
    setState(() {
      checkOpacity = check;
    });
  }

  dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: FilterRequisitionApproveDialog(
            filter: filterData,
            sendData: (value) => setlLstFilter(value),
          ),
        );
      },
    );
  }
}
