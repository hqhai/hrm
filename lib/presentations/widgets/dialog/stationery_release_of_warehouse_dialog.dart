import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/domain/entities/reqisition/stationery/stationery.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_total_minute.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_button_list_stationery.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet_stationery.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ReleaseOfWarehouseAddDialog extends StatefulWidget {
  const ReleaseOfWarehouseAddDialog(
      {super.key, this.requisitionReleaseOfWarehouse, this.releaseOfWarehouse});

  final ValueChanged<WarehouseReleaseds>? requisitionReleaseOfWarehouse;
  final WarehouseReleaseds? releaseOfWarehouse;

  @override
  State<ReleaseOfWarehouseAddDialog> createState() => _ReleaseOfWarehouseAddDialogState();
}

class _ReleaseOfWarehouseAddDialogState extends State<ReleaseOfWarehouseAddDialog> {
  final TextEditingController productController = TextEditingController(),
      explainController = TextEditingController(),
      numberOfController = TextEditingController(),
      noteController = TextEditingController();
  String explain = '', note = '', product = '', unit = '';
  int numberOf = 0;
  Stationery stationery = const Stationery(id: '', product: '', unitPrice: '0', unit: '');

  @override
  void initState() {
    productController.text = widget.releaseOfWarehouse?.product ?? "";
    explainController.text = widget.releaseOfWarehouse?.product ?? "";
    numberOfController.text = (widget.releaseOfWarehouse?.quantity ?? 0).toString();
    noteController.text = widget.releaseOfWarehouse?.note ?? "";
    explain = widget.releaseOfWarehouse?.product ?? "";
    note = widget.releaseOfWarehouse?.note ?? "";
    unit = widget.releaseOfWarehouse?.unit ?? '';
    numberOf = widget.releaseOfWarehouse?.quantity ?? 0;
    super.initState();
  }

  setStationery(Stationery value) {
    setState(() {
      stationery = value;
      product = value.product ??"";
      unit = value.unit ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    final colors = AppTheme.getColors(context);
    return Container(
      height: height * 0.75,
      padding: const EdgeInsets.all(SpacingUnit.x2),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
              child: Row(
                children: [
                  Text(
                    appLocalizations.product,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    width: SpacingUnit.x4,
                  ),
                  GestureDetector(
                    onTap: () => _showBottomSheet(context),
                    child: Icon(
                      Icons.add,
                      size: SpacingUnit.x8,
                      color: colors.success,
                    ),
                  )
                ],
              ),
            ),
            ItemAddStationeryDialog(check: false, product: explain, unit: unit),
            ItemCreateInput(
              title: appLocalizations.explain,
              inputController: explainController,
              onChange: (value) => _setExplain(value),
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
      widget.requisitionReleaseOfWarehouse?.call(WarehouseReleaseds(
        product: product,
        note: note,
        unit: unit,
        quantity: numberOf,
        explain: explain
      ));
    });
    Navigator.of(context).pop();
  }

  _setNumber(String value) {
    setState(() {
      numberOf = int.parse(value);
    });
  }


  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetStationeryWidget(
          onChange: (value) => setStationery(value),
        );
      },
    );
  }
}
