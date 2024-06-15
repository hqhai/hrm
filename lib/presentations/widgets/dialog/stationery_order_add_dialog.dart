import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/domain/entities/reqisition/stationery/stationery.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_total_minute.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_button_list_stationery.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_dialog.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_into_money.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet_stationery.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class StationeryOderAddDialog extends StatefulWidget {
  const StationeryOderAddDialog({super.key, this.requisitionStationery, this.stationery});

  final ValueChanged<Stationeries>? requisitionStationery;
  final Stationeries? stationery;

  @override
  State<StationeryOderAddDialog> createState() => _StationeryOderAddDialogState();
}

class _StationeryOderAddDialogState extends State<StationeryOderAddDialog> {
  final TextEditingController explainController = TextEditingController(),
      numberOfController = TextEditingController(),
      noteController = TextEditingController(),
      unitPriceController = TextEditingController();
  String explain = '', note = '', unit = '', month = '', product = '';
  double intoMoney = 0, unitPrice = 0;
  int numberOf = 0;
  Stationery stationery = const Stationery(id: '', product: '', unitPrice: '0', unit: '');

  setStationery(Stationery value) {
    setState(() {
      stationery = value;
      product = value.product??"";
      unitPrice = double.parse((value.unitPrice ?? '0').replaceAll(',', ''));
      explain = value.product ?? "";
      unit = value.unit ?? "";
    });
  }

  @override
  void initState() {
    explainController.text = widget.stationery?.product ?? "";
    numberOfController.text = (widget.stationery?.quantity ?? 0).toString();
    noteController.text = widget.stationery?.note ?? "";
    unitPriceController.text = (widget.stationery?.unitPrice ?? 0).toString();
    explain = widget.stationery?.product ?? "";
    unit =  widget.stationery?.unit ?? "";
    note = widget.stationery?.note ?? "";
    numberOf = widget.stationery?.quantity ?? 0;
    unitPrice = widget.stationery?.unitPrice ?? 0;
    intoMoney = widget.stationery?.amount ?? 0;
    super.initState();
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
            ItemAddStationeryDialog(
                check: true,
                unit: unit,
                unitPrice: double.parse((stationery.unitPrice ?? '0').replaceAll(',', '')),
                product: explain),
            ItemCreateTotalMinute(
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
              callbackAdd: () => setAdd(),
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

  setAdd() {
    setState(() {
      widget.requisitionStationery?.call(Stationeries(
          product: explain,
          unitPrice: unitPrice,
          note: note,
          unit: unit,
          quantity: numberOf,
          amount: numberOf * unitPrice));
    });
    Navigator.of(context).pop();
  }

  _setNumber(String value) {
    setState(() {
      numberOf = int.parse(value);
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
}
