import 'dart:math';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/pages/activate/requisition/item_list_requisition.dart';
import 'package:base_app/presentations/pages/activate/requisition/popup_menu_requisition_list.dart';
import 'package:base_app/presentations/pages/activate/requisition/wrap_filter.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/filter_request_self_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final requisitionListPageRoute = GoRoute(
    path: Pages.requisitionListPage,
    name: Pages.requisitionListPage,
    builder: (context, GoRouterState state) => const RequisitionListPage());

class RequisitionListPage extends StatefulWidget {
  const RequisitionListPage({super.key});

  @override
  State<RequisitionListPage> createState() => _RequisitionListPageState();
}

class _RequisitionListPageState extends State<RequisitionListPage> {
  bool checkOpacity = false;
  var random = Random();
  int pageIndex = 1, totalItems = 0, lengthList = 0;
  late ScrollController controller;
  RequisitionEnum status = RequisitionEnum.init;
  List<StatusRequestEnum> listStatusFilter = [];
  FilterDialogModel filterData = const FilterDialogModel();

  @override
  void initState() {
    dI<RequisitionBloc>().add(GetRequisitionsByFilterEvent(
      page: pageIndex,
    ));
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    status;
    if (lengthList <= totalItems &&
        status == RequisitionEnum.success &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<RequisitionBloc>().add(GetRequisitionsByFilterEvent(
        listStatusRequisition: listStatusFilter,
        flowId: filterData.flowId,
        startTime: filterData.startTime,
        endTime: filterData.endTime,
        page: pageIndex,
      ));
    }
  }

  setlLstFilter(FilterDialogModel value) {
    setState(() {
      filterData = value;
      listStatusFilter = value.statuses ?? [];
    });
    dI<RequisitionBloc>().add(GetRequisitionsByFilterEvent(
      listStatusRequisition: listStatusFilter,
      flowId: filterData.flowId,
      startTime: filterData.startTime,
      endTime: filterData.endTime,
      page: 1,
    ));
  }

  _listener(BuildContext context, RequisitionState state) {
    setState(() {
      status = state.statusGetByFilter;
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
        title: (Text(
          appLocalizations.singleWordList,
          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
        )),
        actions: [PopupMenuRequisitionList(onChangeCheckOpacity: (value) => _opacity(value))],
      ),
      body: Opacity(
        opacity: checkOpacity ? 0.5 : 1,
        child: BlocConsumer<RequisitionBloc, RequisitionState>(
          listener: (context, state) => _listener(context, state),
          listenWhen: (previous, current) => _listenWhen(previous.requisitions, current.requisitions),
          buildWhen: (previous, current) => previous.requisitions != current.requisitions,
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  height: height * 0.04,
                  margin: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                  child: Stack(
                    children: [
                      if (listStatusFilter.isEmpty)
                        GestureDetector(
                          onTap: () => _setAll(),
                          child: Container(
                            padding: const EdgeInsets.all(
                              SpacingUnit.x1,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                SpacingUnit.x1,
                              ),
                              color: CustomsColor.colorBackground,
                              border: Border.all(
                                color: colors.text,
                                width: SpacingUnit.x0_25,
                              ),
                            ),
                            child: Text(
                                _checkFilter()
                                    ? appLocalizations.all
                                    : appLocalizations.removeFilter,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                          ),
                        ),
                      if (listStatusFilter.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: WrapFilter(
                            listFilter: listStatusFilter,
                            onChange: (value) => removeListFilter(value),
                          ),
                        ),
                      Align(
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
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                  margin: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                  height: height * 0.78,
                  decoration: BoxDecoration(
                    color: CustomsColor.colorBackground,
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
                                ItemRequisitionList(id: state.requisitions[index].id),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(SpacingUnit.x20),
                                  color: CustomsColor.colorBackground,
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

  bool _checkFilter() {
    bool check = filterData.department == null &&
        filterData.startTime == null &&
        filterData.endTime == null &&
        filterData.type == null;
    return check;
  }

  _setAll() {
    if (!_checkFilter()) {
      setState(() {
        filterData = const FilterDialogModel();
      });
      dI<RequisitionBloc>().add(
        GetRequisitionsByFilterEvent(
          listStatusRequisition: listStatusFilter,
          flowId: filterData.flowId,
          startTime: filterData.startTime,
          endTime: filterData.endTime,
          page: 1,
        ),
      );
    }
  }

  _opacity(bool check) {
    setState(() {
      checkOpacity = check;
    });
  }

  removeListFilter(StatusRequestEnum e) {
    setState(() {
      listStatusFilter.remove(e);
      filterData = filterData.copyWith(statuses: listStatusFilter);
    });
    dI<RequisitionBloc>().add(GetRequisitionsByFilterEvent(
      listStatusRequisition: listStatusFilter,
      flowId: filterData.flowId,
      startTime: filterData.startTime,
      endTime: filterData.endTime,
      page: 1,
    ));
  }

  dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: FilterRequestSelfDialog(
            sendData: (value) => setlLstFilter(value),
          ),
        );
      },
    );
  }

  bool _listenWhen(List<Request> requisitionsP, List<Request> requisitionsC) {
    return requisitionsP != requisitionsC;
  }
}
