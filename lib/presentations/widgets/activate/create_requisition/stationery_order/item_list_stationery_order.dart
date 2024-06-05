import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_total_minute.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_button_list_stationery.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/stationery_order/item_into_money.dart';
import 'package:flutter/material.dart';

class ItemListStationeryOder extends StatefulWidget {
  const ItemListStationeryOder({
    super.key,
    this.explain,
    this.note,
    this.intoMoney,
    this.numberOf,
    this.unitPrice,
  });

  final ValueChanged<String>? explain, note;
  final ValueChanged<int>? unitPrice, numberOf, intoMoney;

  @override
  State<ItemListStationeryOder> createState() => _ItemListStationeryOderState();
}

class _ItemListStationeryOderState extends State<ItemListStationeryOder> {
  final TextEditingController explainController = TextEditingController(),
      unitController = TextEditingController(),
      numberOfController = TextEditingController(),
      noteController = TextEditingController(),
      unitPriceController = TextEditingController();
  String explain = '', unit = '', note = '';
  int numberOf = 0, unitPrice = 0, intoMoney = 0;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      width: width * 0.85,
      height: height * 0.7,
      child: Column(
        children: [
          ItemCreateInput(
            title: appLocalizations.explain,
            inputController: explainController,
            onChange: (value) => _setExplain(value),
          ),
          Row(
            children: [
              ItemCreateInput(
                title: appLocalizations.unit,
                inputController: unitController,
                onChange: (value) => _setUnit(value),
              ),
              ItemCreateTotalMinute(
                title: appLocalizations.unitPrice,
                totalMinuteController: unitPriceController,
                onChange: (value) => _setUnitPrice(value),
              ),
            ],
          ),
          Row(
            children: [
              ItemCreateTotalMinute(
                title: appLocalizations.unit,
                totalMinuteController: unitController,
                onChange: (value) => _setUnit(value),
              ),
              ItemIntoMoney(
                title: appLocalizations.intoMoney,
                content: _setIntoMoney(),
              )
            ],
          ),
          ItemCreateInput(
            title: appLocalizations.note,
            inputController: noteController,
            onChange: (value) => _setNote(value),
          ),
          ItemButtonListStationery(
            callbackCancel: () => setCancel(),
            callbackAdd: () => setAdd(),
          )
        ],
      ),
    );
  }

  String _setIntoMoney() {
    setState(() {
      intoMoney = unitPrice * numberOf;
    });
    return intoMoney.toString();
  }

  _setExplain(String value) {
    setState(() {
      explain = value;
    });
  }

  _setUnit(String value) {
    setState(() {
      unit = value;
    });
  }

  _setUnitPrice(String value) {
    setState(() {
      unitPrice = value as int;
    });
  }

  _setNote(String value) {
    setState(() {
      note = value;
    });
  }

  setCancel() {}

  setAdd() {}
}


