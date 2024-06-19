import 'dart:math';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_event.dart';
import 'package:base_app/presentations/pages/activate/requisition/popup_menu_requisition_list.dart';
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
  String? status;

  @override
  void initState() {
    super.initState();
  }

  bool _checkFilter() {
    bool check = filterData.department == null &&
        filterData.startTime == null &&
        filterData.endTime == null &&
        filterData.type == null;
    return check;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 0.04,
                margin: const EdgeInsets.symmetric(
                    horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () => _setAll(),
                      child: Container(
                        padding: const EdgeInsets.all(SpacingUnit.x1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SpacingUnit.x1),
                          color: CustomsColor.colorBackground,
                          border: Border.all(
                            color: colors.text,
                            width: SpacingUnit.x0_25,
                          ),
                        ),
                        child: Text(
                            _checkFilter() ? appLocalizations.all : appLocalizations.removeFilter,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
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
              ListviewRequestApprove(
                onChangeStatus: (value) => setStatus(value),
                filterData: filterData,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _opacity(bool check) {
    setState(() {
      checkOpacity = check;
    });
  }

  setlLstFilter(FilterDialogModel value) {
    setState(() {
      filterData = value;
    });
    dI<RequisitionApproveBloc>().add(GetRequisitionsApproveByFilterEvent(
      page: 1,
      status: status,
      departmentId: value.department?.id,
      startTime: value.startTime,
      endTime: value.endTime,
      requisitionTypeEnum: value.type,
    ));
  }

  dialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: FilterRequisitionApproveDialog(
            sendData: (value) => setlLstFilter(value),
          ),
        );
      },
    );
  }

  _setAll() {
    if (!_checkFilter()) {
      setState(() {
        filterData = const FilterDialogModel();
      });
      dI<RequisitionApproveBloc>().add(
        GetRequisitionsApproveByFilterEvent(
          page: 1,
          status: status,
          departmentId: filterData.department?.id,
          startTime: filterData.startTime,
          endTime: filterData.endTime,
          requisitionTypeEnum: filterData.type,
        ),
      );
    }
  }

  setStatus(String value) {
    setState(() {
      status = value;
    });
  }
}
