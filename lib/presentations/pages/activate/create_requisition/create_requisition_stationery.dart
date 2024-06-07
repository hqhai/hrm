import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/stationery/requisition_stationery.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_list_stationery_order.dart';
import 'package:base_app/presentations/widgets/dialog/stationery_order_add_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequisitionStationeryOderPageRoute = GoRoute(
  path: Pages.createRequisitionStationeryOderPage,
  name: Pages.createRequisitionStationeryOderPage,
  builder: (context, GoRouterState state) => const CreateRequisitionStationeryOderPage(),
);

class CreateRequisitionStationeryOderPage extends StatefulWidget {
  const CreateRequisitionStationeryOderPage({super.key});

  @override
  State<CreateRequisitionStationeryOderPage> createState() =>
      _CreateRequisitionStationeryOderPageState();
}

class _CreateRequisitionStationeryOderPageState extends State<CreateRequisitionStationeryOderPage> {
  List<RequisitionStationery> listRequisitionStationery = [
    const RequisitionStationery(
        product: 'Chong chóng tre của Nobita',
        number: 2,
        unit: RequisitionStationeryUnitTypeEnum.pairs,
        note: 'Không mua cũng được',
        unitPrice: 20000,
        money: 40000)
  ];
  List<String> followers = [];

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RequisitionTypeEnum.stationeryOrder.configTypeName,
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
                  appLocalizations.stationeryList,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.14 * listRequisitionStationery.length,
                  padding: const EdgeInsets.all(SpacingUnit.x1),
                  margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                  ),
                  child: ListView.builder(
                    itemCount: listRequisitionStationery.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () =>
                          _getStationeryInList(context, listRequisitionStationery[index], index),
                      child: ItemListStationery(
                        requisitionStationery: listRequisitionStationery[index],
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
                      appLocalizations.moreOfficeProducts,
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
          child: StationeryOderAddDialog(
            requisitionStationery: (value) => setAdd(value),
          ),
        );
      },
    );
  }

  setAdd(RequisitionStationery value) {
    setState(() {
      listRequisitionStationery.add(value);
    });
  }

  _save() {}

  _cancel() {}

  _getStationeryInList(
      BuildContext context, RequisitionStationery listRequisitionStationery, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: StationeryOderAddDialog(
            stationery: listRequisitionStationery,
            requisitionStationery: (value) => setEdit(value, index),
          ),
        );
      },
    );
  }

  setEdit(RequisitionStationery value, int index) {
    setState(() {
      listRequisitionStationery[index] = RequisitionStationery(
          money: value.money,
          number: value.number,
          unit: value.unit,
          note: value.note,
          unitPrice: value.unitPrice,
          product: value.product);
    });
  }

  _setFollower(List<String> value) {
    setState(() {
      followers = value;
    });
  }
}
