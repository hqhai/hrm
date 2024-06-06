import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/stationery/requisition_release_of_warehouse.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_total_minute.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_button_list_stationery.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_station_unit_type.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';

class ReleaseOfWarehouseAddDialog extends StatefulWidget {
  const ReleaseOfWarehouseAddDialog(
      {super.key, this.requisitionReleaseOfWarehouse, this.releaseOfWarehouse});

  final ValueChanged<RequisitionReleaseOfWarehouse>? requisitionReleaseOfWarehouse;
  final RequisitionReleaseOfWarehouse? releaseOfWarehouse;

  @override
  State<ReleaseOfWarehouseAddDialog> createState() => _ReleaseOfWarehouseAddDialogState();
}

class _ReleaseOfWarehouseAddDialogState extends State<ReleaseOfWarehouseAddDialog> {
  final TextEditingController productController = TextEditingController(),
      explainController = TextEditingController(),
      numberOfController = TextEditingController(),
      noteController = TextEditingController();
  String explain = '', note = '', product = '';
  RequisitionStationeryUnitTypeEnum unit = RequisitionStationeryUnitTypeEnum.pairs;
  int numberOf = 0;

  @override
  void initState() {
    productController.text = widget.releaseOfWarehouse?.product ?? "";
    explainController.text = widget.releaseOfWarehouse?.product ?? "";
    numberOfController.text = (widget.releaseOfWarehouse?.number ?? 0).toString();
    noteController.text = widget.releaseOfWarehouse?.note ?? "";
    explain = widget.releaseOfWarehouse?.product ?? "";
    note = widget.releaseOfWarehouse?.note ?? "";
    unit = widget.releaseOfWarehouse?.unit ?? RequisitionStationeryUnitTypeEnum.pairs;
    numberOf = widget.releaseOfWarehouse?.number ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      height: height * 0.75,
      padding: const EdgeInsets.all(SpacingUnit.x2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemCreateInput(
              title: appLocalizations.product,
              inputController: productController,
              onChange: (value) => _setProduct(value),
            ),
            ItemCreateInput(
              title: appLocalizations.explain,
              inputController: explainController,
              onChange: (value) => _setExplain(value),
            ),
            ItemStationeryUnitType(
              title: appLocalizations.unit,
              onChangeValue: (value) => _setUnit(value),
            ),
            ItemCreateTotalMinute(
              title: appLocalizations.numberOf,
              totalMinuteController: numberOfController,
              onChange: (value) => _setNumber(value),
            ),
            ItemCreateInput(
              title: appLocalizations.note,
              inputController: noteController,
              onChange: (value) => _setNote(value),
            ),
            ItemButtonListStationery(
              callbackCancel: () => popDialog(context),
              callbackAdd: () => setAdd(),
            )
          ],
        ),
      ),
    );
  }

  _setExplain(String value) {
    setState(() {
      explain = value;
    });
  }

  _setNote(String value) {
    setState(() {
      note = value;
    });
  }

  setAdd() {
    setState(() {
      widget.requisitionReleaseOfWarehouse?.call(RequisitionReleaseOfWarehouse(
        product: product,
        note: note,
        unit: unit,
        number: numberOf,
        explain: explain
      ));
    });
    Navigator.of(context).pop();
  }

  _setUnit(RequisitionStationeryUnitTypeEnum value) {
    setState(() {
      unit = value;
    });
  }

  _setNumber(String value) {
    setState(() {
      numberOf = int.parse(value);
    });
  }

  _setProduct(String value) {
    setState(() {
      product = value;
    });
  }
}
