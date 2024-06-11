import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/release_of_warehouse/item_list_release_of_warehouse.dart';
import 'package:base_app/presentations/widgets/dialog/stationery_release_of_warehouse_dialog.dart';
import 'package:flutter/material.dart';
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
  List<User> followers = [];

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
      body: SingleChildScrollView(
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
                    callbackSave: () => _save(),
                    callbackCancel: () => _cancel(),
                  ),
                )
              ],
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

  _save() {}

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
      followers = value;
    });
  }
}
