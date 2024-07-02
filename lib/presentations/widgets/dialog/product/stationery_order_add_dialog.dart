import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/domain/entities/reqisition/stationery/stationery.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_total_minute.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_add.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_button_list_stationery.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_dialog.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_into_money.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_stationery.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:flutter/material.dart';

class StationeryOderAddDialog extends StatefulWidget {
  const StationeryOderAddDialog({super.key, this.requisitionStationery, this.stationery});

  final ValueChanged<Stationeries>? requisitionStationery;
  final Stationeries? stationery;

  @override
  State<StationeryOderAddDialog> createState() => _StationeryOderAddDialogState();
}

class _StationeryOderAddDialogState extends State<StationeryOderAddDialog> {
  final TextEditingController productController = TextEditingController(),
      unitController = TextEditingController(),
      unitPriceController = TextEditingController(),
      numberOfController = TextEditingController(),
      noteController = TextEditingController();

  String note = '',
      unit = '',
      product = '',
      errorExplain = '',
      errorProduct = '',
      errorNumberOf = '';
  double intoMoney = 0, unitPrice = 0;
  int numberOf = 0;
  Stationery stationery = const Stationery(id: '', product: '', unitPrice: '0', unit: '');

  bool checkOnClick(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final bool checkProduct = product != '';
    final bool checkNumberOf = numberOf > 0;
    setState(() {
      errorProduct = checkProduct ? "" : appLocalizations.cannotBeLeftBlank;
      errorNumberOf = checkNumberOf ? "" : appLocalizations.quantityCannotBeZero;
    });
    return checkProduct && checkNumberOf;
  }

  setStationery(Stationery value) {
    setState(() {
      stationery = value;
      unitPrice = double.parse((value.unitPrice ?? '0').replaceAll(',', ''));
      product = value.product ?? "";
      unit = value.unit ?? "";
      productController.text = value.product ?? "";
      unitController.text = value.unit ?? "";
      unitPriceController.text = (value.unitPrice ?? '0').replaceAll(',', '');
      intoMoney = unitPrice * numberOf;
    });
  }

  @override
  void initState() {
    productController.text = widget.stationery?.product ?? "";
    unitController.text = widget.stationery?.unit ?? "";
    unitPriceController.text = (widget.stationery?.unitPrice ?? 0).toString();
    numberOfController.text = (widget.stationery?.quantity ?? 0).toString();
    noteController.text = widget.stationery?.note ?? "";
    product = widget.stationery?.product ?? "";
    unit = widget.stationery?.unit ?? "";
    note = widget.stationery?.note ?? "";
    numberOf = widget.stationery?.quantity ?? 0;
    unitPrice = widget.stationery?.unitPrice ?? 0;
    stationery = stationery.copyWith(unitPrice: unitPrice.toString());
    intoMoney = widget.stationery?.amount ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(SpacingUnit.x3),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemAdd(
              title: appLocalizations.product,
              callback: () => _showBottomSheet(context),
              errorProduct: errorProduct,
            ),
            ItemAddStationeryDialog(
              check: true,
              onChangeProduct: (value) => setProduct(value),
              onchangeUnit: (value) => setUnit(value),
              onChangeUnitPrice: (value) => setUnitPrice(value),
              productController: productController,
              unitController: unitController,
              unitPriceController: unitPriceController,
              /* unit: unit,
                unitPrice: double.parse((stationery.unitPrice ?? '0').replaceAll(',', '')),
                product: product*/
            ),
            ItemCreateTotalMinute(
              error: errorNumberOf,
              title: appLocalizations.numberOf,
              totalMinuteController: numberOfController,
              onChange: (value) => _setNumber(value),
            ),
            ItemIntoMoney(
              title: appLocalizations.intoMoneyNoVAT,
              content: intoMoney.toInt().toString(),
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

  _setNote(String value) {
    setState(() {
      note = value;
    });
  }

  setAdd(BuildContext context) {
    if (checkOnClick(context)) {
      widget.requisitionStationery?.call(Stationeries(
          product: product,
          unitPrice: unitPrice,
          note: note,
          unit: unit,
          quantity: numberOf,
          amount: numberOf * unitPrice));
      Navigator.of(context).pop();
    }
  }

  _setNumber(String value) {
    setState(() {
      numberOf = value != '' ? int.parse(value) : 0;
      intoMoney = unitPrice * numberOf;
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

  setProduct(String value) {
    setState(() {
      product = value;
    });
  }

  setUnit(String value) {
    setState(() {
      unit = value;
    });
  }

  setUnitPrice(double value) {
    setState(() {
      unitPrice = value;
    });
  }
}
