import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/domain/entities/reqisition/stationery/stationery.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_total_minute.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_add.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_button_list_stationery.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_stationery.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:flutter/material.dart';

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
  String explain = '',
      note = '',
      product = '',
      unit = '',
      errorProduct = '',
      errorNumberOf = '',
      errorExplain = '';
  int numberOf = 0;
  Stationery stationery = const Stationery(id: '', product: '', unitPrice: '0', unit: '');

  @override
  void initState() {
    productController.text = widget.releaseOfWarehouse?.product ?? "";
    explainController.text = widget.releaseOfWarehouse?.explain ?? "";
    numberOfController.text = (widget.releaseOfWarehouse?.quantity ?? 0).toString();
    noteController.text = widget.releaseOfWarehouse?.note ?? "";
    product = widget.releaseOfWarehouse?.product ?? "";
    explain = widget.releaseOfWarehouse?.explain ?? "";
    note = widget.releaseOfWarehouse?.note ?? "";
    unit = widget.releaseOfWarehouse?.unit ?? '';
    numberOf = widget.releaseOfWarehouse?.quantity ?? 0;
    super.initState();
  }

  bool checkOnClick(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkProduct = product != '';
    final bool checkNumberOf = numberOf > 0;
    final bool checkExplain = explain.isNotEmpty;
    setState(() {
      errorProduct = checkProduct ? "" : appLocalizations.cannotBeLeftBlank;
      errorNumberOf = checkNumberOf ? "" : appLocalizations.quantityCannotBeZero;
      errorExplain = checkExplain ? "" : appLocalizations.cannotBeLeftBlank;
    });
    return checkProduct && checkNumberOf && checkExplain;
  }

  setStationery(Stationery value) {
    setState(() {
      stationery = value;
      product = value.product ?? "";
      unit = value.unit ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(SpacingUnit.x4),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemAdd(
              callback: () => _showBottomSheet(context),
              title: appLocalizations.product,
              errorProduct: errorProduct,
            ),
            ItemAddStationeryDialog(
              check: false,
              product: product,
              unit: unit,
            ),
            ItemCreateInput(
              error: errorExplain,
              title: appLocalizations.explain,
              inputController: explainController,
              onChange: (value) => _setExplain(value),
            ),
            ItemCreateTotalMinute(
              error: errorNumberOf,
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
              callbackAdd: () => setAdd(context),
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

  setAdd(BuildContext context) {
    if (checkOnClick(context)) {
      setState(() {
        widget.requisitionReleaseOfWarehouse?.call(WarehouseReleaseds(
          product: product,
          note: note,
          unit: unit,
          quantity: numberOf,
          explain: explain,
        ));
      });
      Navigator.of(context).pop();
    }
  }

  _setNumber(String value) {
    setState(() {
      numberOf = value != '' ? int.parse(value) : 0;
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
