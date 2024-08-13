import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/listview_request_self.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/filter_request_self_dialog.dart';
import 'package:flutter/material.dart';
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
  bool checkLoadMore = true;
  FilterDialogModel filterData = const FilterDialogModel();
  StatusRequestEnum status = StatusRequestEnum.process;

  @override
  void initState() {
    super.initState();
  }

  _setFilters(FilterDialogModel value) async {
    setState(() {
      filterData = value;
      checkLoadMore = false;
    });
    Completer completer = Completer<bool>();
    dI<RequisitionBloc>().add(GetRequisitionsByFilterEvent(
      completer: completer,
      flowIds: filterData.flows?.map((e) => e.id).toList(),
      status: filterData.status,
      startTime: dateTimeLocal(filterData.startTime),
      endTime: dateTimeLocal(filterData.endTime),
      page: 1,
    ));
    final checkCompleter = await completer.future;
    if(checkCompleter){
      setState(() {
        checkLoadMore = true;
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
            color: colors.outline.withOpacity(0.3),
            height: SpacingUnit.x0_5,
          ),
        ),
        iconTheme: IconThemeData(color: colors.text),
        centerTitle: true,
        title: Text(
          appLocalizations.yourRequisition,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4_5,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          InkWell(
            onTap: () => _showBottomSheet(context),
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
      body: ListviewRequestSelf(
        checkLoad: checkLoadMore,
        onChangeStatus: (value) => setStatus(value),
        filterData: filterData,
      ),
    );
  }

  setStatus(StatusRequestEnum value) {
    setState(() {
      status = value;
    });
  }

  _showBottomSheet(BuildContext context) async {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return FilterRequestSelfDialog(
          filter: filterData,
          sendData: (value) => _setFilters(value),
        );
      },
    );
  }
}
