import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/config_request_model.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/release_of_warehouse/item_list_release_of_warehouse.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/product/stationery_release_of_warehouse_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestReleaseOfWarehousePageRoute = GoRoute(
    path: Pages.createRequestReleaseOfWarehousePage,
    name: Pages.createRequestReleaseOfWarehousePage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return CreateRequisitionReleaseOfWarehousePage(
        flowId: data['flowId'],
      );
    });

class CreateRequisitionReleaseOfWarehousePage extends StatefulWidget {
  const CreateRequisitionReleaseOfWarehousePage({super.key, this.flowId});

  final String? flowId;

  @override
  State<CreateRequisitionReleaseOfWarehousePage> createState() =>
      _CreateRequisitionReleaseOfWarehousePageState();
}

class _CreateRequisitionReleaseOfWarehousePageState
    extends State<CreateRequisitionReleaseOfWarehousePage> {
  List<WarehouseReleaseds> requisitionReleaseOfWarehouse = [];
  final TextEditingController scheduleController = TextEditingController();
  List<String> followers = [];
  String description = '';
  String errorList = '', errorDescription = '';

  bool _checkValue(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    bool check = requisitionReleaseOfWarehouse.isNotEmpty && description != '';
    setState(() {
      errorDescription = description != '' ? "": appLocalizations.cannotBeLeftBlank;
      errorList = requisitionReleaseOfWarehouse.isNotEmpty ? '' : appLocalizations.thereAreCurrentlyNoProducts;
    });
    return check;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RequisitionTypeEnum.warehouseReleased.configTypeName,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: BlocListener<RequisitionBloc, RequisitionState>(
        listener: (context, state) => _listener(context, state),
        child: SingleChildScrollView(
          child: Container(
            width: width,
            height: height * 0.85,
            padding: const EdgeInsets.all(SpacingUnit.x3),
            margin: const EdgeInsets.all(SpacingUnit.x3),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
              border: Border.all(
                width: 1,
                color: colors.surface,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemCreateInputArea(
                    error: errorDescription,
                    textController: scheduleController,
                    title: appLocalizations.description,
                    onChange: (value) => _setSchedule(value),
                  ),
                  Text(
                    appLocalizations.releaseOfWarehouse,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    width: width,
                    height: height * 0.14 * requisitionReleaseOfWarehouse.length,
                    padding: const EdgeInsets.all(SpacingUnit.x1),
                    margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                    ),
                    child: ListView.builder(
                      itemCount: requisitionReleaseOfWarehouse.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => _getStationeryInList(
                            context, requisitionReleaseOfWarehouse[index], index),
                        child: ItemListReleaseOfWarehouse(
                          requisitionReleaseOfWarehouse: requisitionReleaseOfWarehouse[index],
                          index: index,
                        ),
                      ),
                    ),
                  ),if(errorList != '')
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x1),
                      child: Text(
                        errorList,
                        style: TextStyle(
                          color: colors.error,
                          fontSize: SpacingUnit.x3,
                        ),
                      ),
                    ),

                  GestureDetector(
                    onTap: () => _addStationery(context),
                    child: Container(
                      alignment: Alignment.center,
                      height: SpacingUnit.x10,
                      padding: const EdgeInsets.all(SpacingUnit.x2),
                      decoration: BoxDecoration(
                        color: colors.outlineSuccess,
                        borderRadius: BorderRadius.circular(SpacingUnit.x1),
                        border: Border.all(
                          width: 1,
                          color: colors.text,
                        ),
                      ),
                      child: Text(
                        appLocalizations.addProducts,
                        style: TextStyle(
                          fontSize: SpacingUnit.x3_5,
                          color: colors.background,
                        ),
                      ),
                    ),
                  ),
                  ItemCreateFollower(
                      title: appLocalizations.follower, onChange: (value) => _setFollower(value)),
                  Padding(
                    padding: const EdgeInsets.only(top: SpacingUnit.x3_5),
                    child: ItemButton(
                      callbackSave: () => _save(context),
                      callbackCancel: () => _cancel(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addStationery(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ReleaseOfWarehouseAddDialog(
            requisitionReleaseOfWarehouse: (value) => setAdd(value),
          ),
        );
      },
    );
  }

  setAdd(WarehouseReleaseds value) {
    setState(() {
      requisitionReleaseOfWarehouse.add(value);
    });
  }

  _save(BuildContext context) {
    if (_checkValue(context)) {
      dI<RequisitionBloc>().add(
        PostRequestEvent(
          postRequestRequest: PostRequestRequest(
            followerIds: followers,
            flowId: widget.flowId,
            description: description,
            config: ConfigRequestModel(
              warehourseReleaseds: requisitionReleaseOfWarehouse,
            ),
          ),
        ),
      );
    }
  }

  _cancel() {}

  _getStationeryInList(
      BuildContext context, WarehouseReleaseds requisitionReleaseOfWarehouse, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ReleaseOfWarehouseAddDialog(
            releaseOfWarehouse: requisitionReleaseOfWarehouse,
            requisitionReleaseOfWarehouse: (value) => setEdit(value, index),
          ),
        );
      },
    );
  }

  setEdit(WarehouseReleaseds value, int index) {
    setState(() {
      requisitionReleaseOfWarehouse[index] = WarehouseReleaseds(
          unit: value.unit,
          note: value.note,
          product: value.product,
          explain: value.explain,
          quantity: value.quantity);
    });
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value.map((e) => e.id).toList();
    });
  }

  _setSchedule(String value) {
    setState(() {
      description = value;
    });
  }

  _listener(BuildContext context, RequisitionState state) {
    if (state.status == RequisitionEnum.postRequisitionInit) {
      progressIndicatorDialog(context);
    } else if (state.status == RequisitionEnum.postRequisitionSuccess) {
      Navigator.of(context).pop();
      successDialog(context);
    } else if (state.status == RequisitionEnum.postRequisitionError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }
}
