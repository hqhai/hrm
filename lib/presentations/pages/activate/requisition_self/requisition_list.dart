import 'dart:async';
import 'dart:math';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/item_list_requisition.dart';
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
  bool checkLoadMore = true;
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

  _scrollListener() async {
    if (lengthList < totalItems &&
        checkLoadMore == true &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      final Completer completer = Completer<bool>();
      setState(() {
        checkLoadMore = false;
      });
      dI<RequisitionBloc>().add(GetRequisitionsByFilterEvent(
        listStatusRequisition: listStatusFilter,
        flowId: filterData.flowId,
        startTime: dateTimeLocal(filterData.startTime),
        endTime: dateTimeLocal(filterData.endTime),
        page: pageIndex,
        completer: completer,
      ));
      final check = await completer.future;
      if (check) {
        setState(() {
          checkLoadMore = true;
        });
      }
    }
  }

  setlLstFilter(FilterDialogModel value) {
    setState(() {
      pageIndex = 1;
      filterData = value;
      listStatusFilter = value.statuses ?? [];
    });
    dI<RequisitionBloc>().add(GetRequisitionsByFilterEvent(
      listStatusRequisition: listStatusFilter,
      flowId: filterData.flowId,
      startTime: filterData.startTime,
      endTime: filterData.endTime,
      page: pageIndex,
    ));
  }

  _listener(BuildContext context, RequisitionState state) {
    setState(() {
      totalItems = state.countItem;
      lengthList = state.requisitions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          appLocalizations.singleWordList,
          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
        ),
        actions: [
          GestureDetector(
            onTap: () => dialog(context),
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
      body: Opacity(
        opacity: checkOpacity ? 0.5 : 1,
        child: BlocConsumer<RequisitionBloc, RequisitionState>(
          listener: (context, state) => _listener(context, state),
          listenWhen: (previous, current) =>
              _listenWhen(previous.requisitions, current.requisitions),
          buildWhen: (previous, current) => previous.requisitions != current.requisitions,
          builder: (context, state) {
            return ListView.builder(
              controller: controller,
              itemCount: state.requisitions.length,
              itemBuilder: (context, index) =>
                  ItemRequisitionList(id: state.requisitions[index].id),
            );
          },
        ),
      ),
    );
  }

  removeListFilter(StatusRequestEnum e) {
    setState(() {
      pageIndex = 1;
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
            filter: filterData,
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
